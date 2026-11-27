{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Install fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
  ];

  environment.systemPackages =
    with pkgs;
    [
      neovim
      # Neovim dependencies
      git
      delta
      wget
      gnutar
      gzip
      unzip
      ripgrep
      fzf
      fd
      gcc
      tree-sitter
      lua-language-server

      # Useful tools
      pastel # converts colors in terminal

      # better file watcher
      inotify-tools

      # programming languages / neovim dependencies
      nodejs_22
      rustup

      # programming languages
      typescript

      # Node tooling
      pnpm
      nodemon
      eslint_d

      # Arduino
      arduino-cli
    ]
    ++ lib.optionals config.my.desktop.enable [
      # some gui for neovim
      neovide
      wl-clipboard
    ];

  environment.variables = {
    RUSTC_VERSION = "stable";
  };
}
