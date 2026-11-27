# cubopi

Raspberry Pi 3B, `aarch64-linux`, headless, Ethernet-only, DHCP.

This host uses the generic Nixpkgs `sd-image-aarch64.nix` image:

- mainline kernel (`pkgs.linuxPackages`), which has AArch64 binary-cache coverage
- Raspberry Pi firmware, device trees, and U-Boot
- U-Boot/extlinux boot
- ext4 root and vfat firmware partitions

It deliberately does not use the `nixos-hardware` Raspberry Pi 3 profile, which
selects the downstream Raspberry Pi kernel and is not covered by the NixOS
binary cache.

## SSH keys

Keys are shared by every host in the flake: `configs/ssh-keys.nix` (imported
from `configs/common.nix`) installs every public key file in the flake's
`keys/` directory as an authorized key for `cubo`. To add or rotate keys:

```bash
cd /home/cubo/dotfiles/nix-config
cp ~/.ssh/id_ed25519.pub keys/
git add keys/
```

- One key per line; blank lines and `#` comments are ignored.
- Files starting with `.` (editor swap/backup files) are ignored.
- The flake only sees Git-tracked files, so an untracked key file is invisible
  to the build. `git add` it before evaluating.
- Removing a key file revokes that key on every host.
- An empty `keys/` directory fails evaluation with an assertion: password and
  keyboard-interactive auth are disabled on cubopi, so an image without keys
  would be unreachable over the network.

Password authentication and root login are disabled on this host. Keep serial
or SD-card recovery available until the configured keys have been verified on
first boot.

If you want Tailscale to come up automatically, configure a secret file:

```nix
services.tailscale.authKeyFile = "/run/secrets/tailscale-authkey";
# extraUpFlags only apply when authKeyFile is set.
services.tailscale.extraUpFlags = [ "--ssh" ];
```

Otherwise, Tailscale still starts at boot but needs a one-time login after the
first boot.

## Building from x86_64

The current development machine is the x86_64 cubotab, so building an
AArch64 image requires one of:

- local binfmt emulation, for example
  `boot.binfmt.emulatedSystems = [ "aarch64-linux" ];` on the x86 builder
- a remote AArch64 builder registered with `nix.buildMachines`

Then build from the flake:

```bash
cd /home/cubo/dotfiles/nix-config
nix build .#cubopi-sd-image
ls -lh result/sd-image/
```

The equivalent explicit attribute is:

```bash
nix build .#nixosConfigurations.cubopi.config.system.build.sdImage
```

Evaluation does not require an AArch64 builder, but the actual image build does.

## Flashing

Identify the microSD device carefully; the following command erases it:

```bash
lsblk
zstd -d result/sd-image/*.img.zst -o /tmp/cubopi.img
sudo dd if=/tmp/cubopi.img of=/dev/sdX bs=4M status=progress conv=fsync
sync
```

Replace `/dev/sdX` with the microSD device, not a partition.

## First boot

1. Connect Ethernet and power the Pi.
2. Find the DHCP lease for `cubopi` in the router or DHCP server.
3. Connect with the configured key:

   ```bash
   ssh cubo@<cubopi-ip>
   ```

If SSH is unavailable, use the Pi's serial console on GPIO 14/15 (physical pins
8/10) with a 3.3 V USB-serial adapter, or mount the SD card and inspect the
Keep serial or SD-card recovery available until the SSH keys have
been verified.

### Tailscale

Tailscale is enabled at boot through `home/programs/tailscale.nix`, but unless
`authKeyFile` is configured the node still needs a one-time login:

```bash
sudo tailscale up
# or, if Tailscale SSH is desired:
sudo tailscale up --ssh
tailscale status
```

### SSH

SSH is key-only:

- `PasswordAuthentication = false`
- `KbdInteractiveAuthentication = false`
- `PermitRootLogin = "no"`

## Operations and risks

- `system.autoUpgrade` is enabled with `allowReboot = true`. On a flake-based
  Pi, make sure `system.autoUpgrade.flake` points at a valid flake reference;
  otherwise unattended upgrades may fail or use an unintended configuration.
- `nix.gc` runs weekly and `nix.optimise` is scheduled daily at 17:45. Consider
  disabling `nix.optimise` on the Pi 3B if it causes noticeable load.
- The generic SD-image profile adds installer-oriented packages such as `w3m`
  and `testdisk`. The filesystem list has been trimmed to `ext4` and `vfat`, but
  those packages remain in the image.
- The SD-card firmware partition, U-Boot, and device trees are populated at
  image-build time. They are not refreshed by ordinary `nixos-rebuild` runs;
  reflash the image for firmware or bootloader updates.
- `proton-vpn-cli` and `arduino-cli` have not been build-tested on AArch64.
  The current configuration evaluates, but a real build may surface upstream
  platform issues.
- Mainline Bluetooth on the Pi 3 may require board-specific attach/overlay
  handling. Ethernet is the primary and supported network path.
- The Pi 3B has 1 GB of RAM and no swap is configured. Avoid large local builds
  on the device; use an AArch64 builder instead.
- Use a reliable power supply and a good-quality microSD card to reduce
  corruption risk.

## Evaluation checks

```bash
cd /home/cubo/dotfiles/nix-config
nix flake check --no-build
nix eval .#nixosConfigurations.cubopi.config.system.build.sdImage.drvPath
nix eval .#nixosConfigurations.cubopi.config.system.build.toplevel.drvPath
```

The x86 hosts can additionally be checked with:

```bash
nixos-rebuild dry-build --flake .#deskcubo
nixos-rebuild dry-build --flake .#cubobook
nixos-rebuild dry-build --flake .#cubotab
```
