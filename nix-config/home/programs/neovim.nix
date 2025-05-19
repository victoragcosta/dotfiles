{pkgs, ...}: {
  users.users.cubo.packages = with pkgs; [ 
    neovim
  ];
  environment.systemPackages = with pkgs; [
    # Neovim dependencies
    git
    wget
    gnutar
    gzip
    unzip
    ripgrep
    fd
    gcc
    tree-sitter
    wl-clipboard

    # programming languages / neovim dependencies
    nodejs_22
    rustup

    # Node tooling
    pnpm
  ];
}
