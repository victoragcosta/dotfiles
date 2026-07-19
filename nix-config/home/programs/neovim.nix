{ pkgs, ... }: {
  # Install fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
  ];

  environment.systemPackages = with pkgs; [
    neovim
    # some gui for neovim
    neovide
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
    wl-clipboard

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
  ];
}
