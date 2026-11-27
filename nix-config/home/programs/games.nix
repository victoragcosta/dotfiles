{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.my.desktop.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkForce true;

    users.users.cubo.packages = [
      pkgs.vintagestory
      # Minecraft
      (pkgs.prismlauncher.overrideAttrs (
        oldAttrs:
        let
          extraLibs = with pkgs; [
            glib
            nss
            nspr
            atk
            libdrm
            expat
            libxkbcommon
            libgbm
            gtk3
            pango
            cairo
            alsa-lib
            dbus
            at-spi2-core
            cups
            udev
            systemd
            libX11
            libXcomposite
            libXdamage
            libXext
            libXfixes
            libXrandr
          ];
        in
        {
          buildInputs = (oldAttrs.buildInputs or [ ]) ++ extraLibs;
          qtWrapperArgs = (oldAttrs.qtWrapperArgs or [ ]) ++ [
            "--prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath extraLibs}"
          ];
        }
      ))
      # For accessing sunshine
      pkgs.moonlight-qt
      pkgs.ckan
    ];

    environment.systemPackages = with pkgs; [
      # Package that helps games run with priority
      gamemode
      # Game backup
      ludusavi
    ];
  };
}
