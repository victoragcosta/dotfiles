{
  lib,
  ...
}:
{
  imports = [ ./common.nix ];

  # Headless hosts should not include the desktop/GUI profile by default.
  my.desktop.enable = lib.mkDefault false;

  # Defense in depth: the common module does not enable X, but make the
  # headless intent explicit without preventing a host from overriding it.
  services.xserver.enable = lib.mkDefault false;
}
