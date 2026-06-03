{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official unstable package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # NixOS official package source, using the nixos-25.05 branch here
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # Extra recent packages for XR
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-xr,
      home-manager,
      plasma-manager,
      nix-flatpak,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      stable-pkgs = import nixpkgs-stable ({
        inherit system;
        config = {
          allowUnfree = true;
        };
      });
      xr-pkgs = import nixpkgs ({
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [ nixpkgs-xr.overlays.default ];
      });
      mkHostConfig =
        { hostname, config, ... }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inputs // {
            inherit system;
            inherit stable-pkgs;
            inherit xr-pkgs;
          };
          modules = [
            nix-flatpak.nixosModules.nix-flatpak

            config
            ./home/default.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cubo = ./home/home.nix;
              home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        deskcubo = mkHostConfig {
          hostname = "deskcubo";
          config = ./configs/deskcubo/configuration.nix;
        };
        cubobook = mkHostConfig {
          hostname = "cubobook";
          config = ./configs/cubobook/configuration.nix;
        };
      };
    };
}
# vim: ts=2 sts=2 sw=2:
