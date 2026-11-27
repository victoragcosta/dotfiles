{
  config,
  lib,
  pkgs,
  stable-pkgs,
  ...
}:
{
  config = lib.mkMerge [
    {
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      users.users.cubo.packages =
        with pkgs;
        [
          android-tools
          proton-vpn-cli
        ]
        ++ lib.optionals config.my.desktop.enable [
          vial
          thunderbird
          spotify
          orca-slicer
          zapzap
          discord
          stable-pkgs.freecad
          easyeffects
          libreoffice-qt6-fresh
          yt-dlp
          theclicker
          proton-vpn
        ];

      environment.systemPackages = [ pkgs.rclone ];

      services.cloudflare-warp.enable = true;
    }
    (lib.mkIf config.my.desktop.enable {
      # Add flatpak
      services.flatpak.enable = true;
      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };

      # Fix libreoffice using x11 instead of wayland
      environment.variables = {
        QT_QPA_PLATFORM = "wayland";
      };
    })
  ];
}
