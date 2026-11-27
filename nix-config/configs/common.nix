{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./options.nix
    ./ssh-keys.nix
  ];

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
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable bluetooth support
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    powerOnBoot = lib.mkDefault true;
    settings.General.Experimental = lib.mkDefault true;
  };

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
    lazygit
    stow
    usbutils
  ];

  # List programs you want to enable
  programs = {
    # Improves dynamically linked libraries
    nix-ld.enable = true;
  };

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Auto upgrading
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatic optimization
  nix.optimise = {
    automatic = true;
    dates = [ "17:45" ];
  };
}
