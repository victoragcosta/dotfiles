{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.programs.steam.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkOverride true;

    # Add steam
    programs.steam = {
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
      # Open ports in the firewall for Steam Local Network Game Transfers
      localNetworkGameTransfers.openFirewall = true;
      # Enables protontricks for better tinkering with game environments
      protontricks.enable = true;
      extraCompatPackages = with pkgs;
        [
          # For better proton environments
          proton-ge-bin
        ];
    };

    # Silently auto start steam on startup
    systemd.user.services.steam = {
      enable = true;
      description = "Open Steam in the background at boot";
      serviceConfig = {
        ExecStart = "${pkgs.steam}/bin/steam -nochatui -nofriendsui -silent %U";
        wantedBy = [ "graphical-session.target" ];
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
