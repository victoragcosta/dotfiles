# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  ...
}:
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = ""; # fix ç in us-intl
      LANG = "pt_BR.UTF-8"; # fix ç in us-intl
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_CTYPE = "pt_BR.UTF-8"; # fix ç in us-intl
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  environment.variables = {
    # Cedilla fix
    # GTK_IM_MODULE = "cedilla";
    # QT_IM_MODULE = "cedilla";

    # Better compatibility with fcitx5
    XMODIFIERS = "@im=fcitx";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable bluetooth support
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    powerOnBoot = lib.mkDefault true;
    settings.General.Experimental = lib.mkDefault true;
  };
  # Enable advanced features for Xbox and similar controllers
  hardware.xpadneo.enable = true;

  # Experimental
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    vim
    git
    wget
    gnutar
    usbutils
    lazygit
    stow
    ghostty
    brave
    vlc
    # torrential # removed
    gparted
    kdePackages.kalk
    gamemode
    quickemu
  ];

  # setup virtualisation
  virtualisation.spiceUSBRedirection.enable = true;

  # List programs you want to enable
  programs = {
    # Improves dynamically linked libraries
    nix-ld.enable = true;
    steam.enable = lib.mkDefault true;
    # Adds better support for running AppImages
    appimage.enable = lib.mkDefault true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
  # Enables my VR configuration at ../home/vr.nix if this is set to true
  my.vr = {
    enable = lib.mkDefault false;
    programs = {
      kaon.enable = lib.mkDefault false;
      wayvr.enable = lib.mkDefault true;
    };
  };

  # List services that you want to enable:
  services = {
    # Auto mount drives
    udisks2.enable = true;

    # Configure and install udev related packages
    udev.packages = with pkgs; [
      vial
      via
    ];

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable fwupd to update BIOS and other firmwares
    fwupd.enable = true;

    # Enable MongoDB server
    mongodb.enable = true;

    # Disable sunshine by default
    sunshine = {
      enable = lib.mkDefault false;
      switch-screen = lib.mkDefault false;
    };
  };

  # Auto upgrading
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };
}
