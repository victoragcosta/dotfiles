{pkgs, ...}: {
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
    bottles
    wine
    freecad
    stremio
    android-tools
  ];

}
