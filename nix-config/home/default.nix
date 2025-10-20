{ ... }: {
  imports = [
    # keep separate lines
    ./programs/default.nix
    ./shell.nix
    ./home-manager.nix
  ];
}
