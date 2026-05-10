{ ... }: {
  imports = [
    ./controllers.nix
    ./games.nix
    ./general.nix
    ./mongodb.nix
    ./neovim.nix
    ./steam.nix
    ./sunshine.nix
    ./tailscale.nix
  ];
}
