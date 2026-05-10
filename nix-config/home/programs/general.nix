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
    # For configuring logitech devices
    solaar
    # For testing joysticks and wheels
    jstest-gtk
    # For configuring gaming wheels
    oversteer
  ];

  services.udev.extraRules = ''
    # This rule was added by Solaar.
    #
    # Allows non-root users to have raw access to Logitech devices.
    # Allowing users to write to the device is potentially dangerous
    # because they could perform firmware updates.

    ACTION == "remove", GOTO="solaar_end"
    SUBSYSTEM != "hidraw", GOTO="solaar_end"

    # USB-connected Logitech receivers and devices
    ATTRS{idVendor}=="046d", GOTO="solaar_apply"

    # Lenovo nano receiver
    ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6042", GOTO="solaar_apply"

    # Bluetooth-connected Logitech devices
    KERNELS == "0005:046D:*", GOTO="solaar_apply"

    GOTO="solaar_end"

    LABEL="solaar_apply"

    # Allow any seated user to access the receiver.
    # uaccess: modern ACL-enabled udev
    TAG+="uaccess"

    # Grant members of the "plugdev" group access to receiver (useful for SSH users)
    #MODE="0660", GROUP="plugdev"

    LABEL="solaar_end"
    # vim: ft=udevrules
  '';

  # Fix libreoffice using x11 instead of wayland
  environment.variables = { QT_QPA_PLATFORM = "wayland"; };
}
