{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official unstable package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
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
      mkHostConfig =
        {
          hostname,
          config,
          system ? "x86_64-linux",
          homeModules ? [ ./home/default.nix ],
          homeConfig ? ./home/home.nix,
          ...
        }:
        let
          stable-pkgs = import nixpkgs-stable {
            inherit system;
            config = {
              allowUnfree = true;
            };
          };
          xr-pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
            };
            overlays = [ nixpkgs-xr.overlays.default ];
          };
        in
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
          ]
          ++ homeModules
          ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.cubo = homeConfig;
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
        cubotab = mkHostConfig {
          hostname = "cubotab";
          config = ./configs/cubotab/configuration.nix;
        };
        cubopi = mkHostConfig {
          hostname = "cubopi";
          system = "aarch64-linux";
          config = ./configs/cubopi/configuration.nix;
          homeModules = [ ./home/headless.nix ];
        };
      };

      packages = {
        x86_64-linux = {
          cubopi-sd-image = self.nixosConfigurations.cubopi.config.system.build.sdImage;
        };
      };
    };
}
# vim: ts=2 sts=2 sw=2:
