{pkgs, ...}: {
  users.users.cubo.packages = with pkgs; [ 
    neovim
  ];
  environment.systemPackages = with pkgs; [
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

    # programming languages
    nodejs_22
    rustup
  ];
}
