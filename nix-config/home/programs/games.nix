{ pkgs, lib, make-pkgs-unstable, ... }:
let
  unstable-pkgs = make-pkgs-unstable {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # Needed for vintagestory
        "dotnet-runtime-7.0.20"
      ];
    };
  };
in {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkOverride true;

  # Add flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  users.users.cubo.packages = [
    unstable-pkgs.vintagestory
    # Minecraft
    (pkgs.prismlauncher.overrideAttrs (oldAttrs:
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
          xorg.libX11
          xorg.libXcomposite
          xorg.libXdamage
          xorg.libXext
          xorg.libXfixes
          xorg.libXrandr
        ];
      in {
        buildInputs = (oldAttrs.buildInputs or [ ]) ++ extraLibs;
        qtWrapperArgs = (oldAttrs.qtWrapperArgs or [ ]) ++ [
          "--prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath extraLibs}"
        ];
      }))
  ];

  environment.systemPackages = with pkgs; [
    # Package that helps games run with priority
    gamemode
    # Game backup
    ludusavi
    rclone # for cloud backup with ludusavi
    # For better proton environments
    protonup-qt
  ];
}
