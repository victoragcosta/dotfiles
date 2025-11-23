{ config, pkgs, unstable-pkgs, ... }: {
  services.tailscale.enable = true;
  services.tailscale.package = unstable-pkgs.tailscale;
}
