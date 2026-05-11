{ pkgs, config, lib }: {
  config = lib.mkIf config.programs.appimage.enable {
    programs.appimage = { binfmt = true; };
  };
}
