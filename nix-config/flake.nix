{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # NixOS official unstable package source
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager = {
      url="github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      make-pkgs-unstable = args:
        import nixpkgs-unstable ({
          inherit system;
          config = { allowUnfree = true; };
        } // args);
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // {
          inherit system;
          inherit make-pkgs-unstable;
        };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./nixos/configuration.nix
          ./home/default.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.cubo = ./home/home.nix;
            home-manager.sharedModules =[plasma-manager.homeModules.plasma-manager];
          }
        ];
      };
    };
}
# vim: ts=2 sts=2 sw=2:
