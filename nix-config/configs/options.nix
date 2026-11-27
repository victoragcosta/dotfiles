{
  lib,
  ...
}:
{
  options.my.desktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether this host should include the desktop/GUI profile.";
  };
}
