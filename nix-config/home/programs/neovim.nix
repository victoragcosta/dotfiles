{ pkgs, ... }: {
  # Install fonts
  fonts.packages = with pkgs; [ nerd-fonts.fira-code fira-code ];

  users.users.cubo.packages = with pkgs; [ neovim ];
  environment.systemPackages = with pkgs; [
    # Neovim dependencies
    git
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

    # programming languages / neovim dependencies
    nodejs_22
    rustup

    # programming languages
    typescript
    typescript-language-server
    svelte-language-server
    tailwindcss-language-server

    # formatters
    stylua
    prettierd

    # Node tooling
    pnpm
    nodemon
  ];
}
