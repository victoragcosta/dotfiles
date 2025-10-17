{ ... }: {

  # To easily find changed configurations you can run
  # `nix run github:nix-community/plasma-manager/trunk#rc2nix > plasma.nix`

  # Enable and configure Plasma settings
  programs.plasma = {
    enable = true;

    #
    # System Settings (Mimic System Settings GUI order)
    #
    # System Settings > Keyboard > Keyboard
    input.keyboard = {
      numlockOnStartup = "on";
      # options = ["ctrl:nocaps"];
    };

    # System Settings > Keyboard > Shortcuts > Plasma Manager
    hotkeys.commands = {
      launch-brave = {
        name = "Launch Brave";
        key = "Meta+Shift+B";
        command = "brave";
      };
    };

    # System Settings > Text & Fonts > Fonts
    fonts = {
      fixedWidth = {
        family = "FiraCode Nerd Font Mono";
        pointSize = 10;
      };
    };

    kwin = {
      # System Settings > Window Management > Desktop Effects > ...
      effects = {
        blur = {
          enable = true;
          noiseStrength = 1;
          strength = 1;
        };
        fallApart.enable = true;
        fps.enable = true;
        minimization = {
          animation = "magiclamp";
          duration = 150;
        };
        slideBack.enable = true;
        translucency.enable = true;
        wobblyWindows.enable = true;
      };
    };

    # System Settings > Screen Locking > Configure Appearance
    kscreenlocker = {
      autoLock = false;
      # timeout = 0;
    };

    powerdevil = {

      # When connected to a charger
      AC = {
        autoSuspend.action = "nothing";
        # autoSuspend.idleTimeout = 10 * 60 * 1000; # 10 min in ms
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 3 * 60 * 1000; # 3 min in ms
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        powerProfile = "performance";
        turnOffDisplay.idleTimeout = 5 * 60 * 1000; # 5 min in ms
        turnOffDisplay.idleTimeoutWhenLocked = 1 * 60 * 1000; # 1 min in ms
        whenLaptopLidClosed = "doNothing";
        whenSleepingEnter = "hybridSleep";
      };

      # When not connected to a charger
      battery = {
        autoSuspend.action = "hibernate";
        autoSuspend.idleTimeout = 5 * 60 * 1000; # 5 min in ms
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 1 * 60 * 1000; # 1 min in ms
        inhibitLidActionWhenExternalMonitorConnected = true;
        powerButtonAction = "showLogoutScreen";
        powerProfile = "powerSaving";
        turnOffDisplay.idleTimeout = 3 * 60 * 1000; # 3 min in ms
        turnOffDisplay.idleTimeoutWhenLocked = 1 * 60 * 1000; # 1 min in ms
        whenLaptopLidClosed = "sleep";
        whenSleepingEnter = "hybridSleep";
      };

      batteryLevels = {
        criticalAction = "hibernate";
        criticalLevel = 5;
        lowLevel = 15;
      };
    };

    #
    # Spectacle
    #
    spectacle = {
      # Spectacle > Configure Spectacle > Shortcuts
      shortcuts = {
        captureActiveWindow = "Meta+@";
        captureCurrentMonitor = "Meta+#";
        captureRectangularRegion = "Meta+Shift+S";
        recordRegion = "Meta+Shift+R";
        recordScreen = "Meta+R";
      };
    };

    # Other shortcuts
    shortcuts = {
      "services/com.mitchellh.ghostty.desktop"."_launch" = "Meta+T";
      "services/org.kde.konsole.desktop"."_launch" = [ ];
      "services/org.kde.plasma.emojier.desktop"."_launch" = "Meta+.";
    };

  };

  # Set Home Manager state version to match NixOS system.stateVersion
  home.stateVersion = "25.05";

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cubo";
  home.homeDirectory = "/home/cubo";

  # Optional: Allow Home Manager to manage itself
  programs.home-manager.enable = true;
}
