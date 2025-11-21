{ pkgs, make-pkgs-unstable, ... }:
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

  # For game streaming to moolight
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    applications = {
      env = { PATH = "$(PATH):$(HOME)/.local/bin"; };
      apps = [
        {
          name = "Desktop";
          image-path = "desktop.png";
        }
        {
          name = "Steam Big Picture";
          detached = [ "setsid steam steam://open/bigpicture" ];
          prep-cmd = [{
            do = "";
            undo = "setsid steam steam://close/bigpicture";
          }];
          image-path = "steam.png";
        }
        {
          name = "Crafttomuck";
          cmd = "prismlauncher -l Crafttomuck -a CuboMagicker";
          image-path =
            "$(HOME)/.local/share/PrismLauncher/icons/curseforge_crafttomuck.png";
        }
      ];
    };
  };

  # Add steam
  programs.steam = {
    enable = true;
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
