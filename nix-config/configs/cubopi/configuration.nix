{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    ../headless.nix
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    ./hardware-configuration.nix
  ];

  # Keep Ghostty's terminfo available so SSH sessions can use
  # TERM=xterm-ghostty without falling back to xterm-256color.
  environment.systemPackages = [ pkgs.ghostty.terminfo ];

  networking.hostName = "cubopi";

  # This host is intentionally headless.
  my.desktop.enable = lib.mkForce false;

  # Keep Home Manager's Plasma module loaded so the option exists, but make
  # sure the headless host never enables it.
  home-manager.users.cubo.programs.plasma.enable = lib.mkForce false;
  home-manager.users.cubo.home.stateVersion = "26.05";

  # Explicitly disable the desktop stack as defense in depth.
  services.xserver.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;
  services.desktopManager.plasma6.enable = lib.mkForce false;

  # The generic AArch64 image boots through U-Boot and extlinux.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.systemd-boot.memtest86.enable = lib.mkForce false;
  boot.loader.grub.enable = lib.mkForce false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # The SD image only needs its ext4 root and the vfat firmware partition.
  # This avoids pulling ZFS, XFS, Btrfs, CIFS, and NTFS tooling into the image.
  boot.supportedFilesystems = lib.mkForce [
    "ext4"
    "vfat"
  ];

  # SSH is key-only. Keep serial or SD-card access available until the
  # configured keys have been verified on first boot.
  services.openssh = {
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  # tailscaled starts at boot and authenticates with the key stored at
  # /var/lib/tailscale/authkey. The file must exist before the service starts
  # and should be readable only by root. extraUpFlags only apply when
  # authKeyFile is set.
  services.tailscale = {
    openFirewall = true;
    authKeyFile = "/var/lib/tailscale/authkey";

    # Enable IP forwarding and advertise cubopi as an exit node. The route
    # still has to be approved in the Tailscale admin console.
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-exit-node" ];

    # extraUpFlags = [ "--ssh" ];
  };

  # cubotab deploys locally built, unsigned paths to the Pi over SSH. Keep
  # this host on a trusted tailnet; remove it if signing keys are configured.
  nix.settings.require-sigs = false;

  # The shared config enables daily upgrades, but no flake reference is set
  # for this host. Build updates on cubotab and push them with --target-host.
  system.autoUpgrade.enable = lib.mkForce false;

  # A 1 GB Pi 3B should not run daily hardlink optimisation, and compressed
  # RAM swap is safer than swapping on the SD card.
  nix.optimise.automatic = lib.mkForce false;
  zramSwap.enable = true;

  system.stateVersion = "26.05";
}
