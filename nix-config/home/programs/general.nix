{ pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Add flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  users.users.cubo.packages = with pkgs; [
    vial
    thunderbird
    spotify
    orca-slicer
    zapzap
    discord
    freecad
    # removed, dunno what to do,
    # but I ain't using it, so I ain't dealing with that now
    # stremio
    android-tools
    mongodb-ce
    mongodb-compass
    easyeffects
    libreoffice-qt6-fresh
    yt-dlp
    theclicker
    lua-language-server
  ];

  # Fix libreoffice using x11 instead of wayland
  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
