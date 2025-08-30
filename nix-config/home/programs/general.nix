{ pkgs, make-pkgs-unstable, ... }:
let unstable-pkgs = make-pkgs-unstable { config = { allowUnfree = true; }; };
in {
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
    unstable-pkgs.freecad
    unstable-pkgs.stremio
    android-tools
    mongodb
    mongodb-compass
    easyeffects
    libreoffice-qt6-fresh
    yt-dlp
  ];

  # Fix libreoffice using x11 instead of wayland
  environment.variables = { QT_QPA_PLATFORM = "wayland"; };
}
