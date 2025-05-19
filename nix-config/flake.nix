{
	description = "A simple NixOS flake";

	inputs = {
		# NixOS official package source, using the nixos-24.11 branch here
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		# NixOS official unstable package source
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				# Import the previous configuration.nix we used,
				# so the old configuration file still takes effect
				./nixos/configuration.nix
				./home/default.nix
			];
		};
	};
}
# vim: ts=2 sts=2 sw=2:
