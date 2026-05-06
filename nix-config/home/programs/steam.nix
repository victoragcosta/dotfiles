{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.programs.steam.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = lib.mkOverride true;

    # Allows steam to run SteamVR
    # See more at https://wiki.nixos.org/wiki/VR#SteamVR
    boot.kernelPatches = [{
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url =
          "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }];

    # Add steam
    programs.steam =
      # Too annoying

      # let
      #   patchedBwrap = pkgs.bubblewrap.overrideAttrs
      #     (o: { patches = (o.patches or [ ]) ++ [ ./bwrap.patch ]; });
      # in 
      {
        # Allows steam to run SteamVR
        # See more at https://wiki.nixos.org/wiki/VR#SteamVR
        # package = pkgs.steam.override {
        #   buildFHSEnv = (args:
        #     ((pkgs.buildFHSEnv.override { bubblewrap = patchedBwrap; }) (args // {
        #       extraBwrapArgs = (args.extraBwrapArgs or [ ])
        #         ++ [ "--cap-add ALL" ];
        #     })));
        # };

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
