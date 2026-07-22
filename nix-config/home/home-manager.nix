{ pkgs, ... }: {
  # Home manager
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  # For plasma-manager
  environment.systemPackages = [
    # installs polonium so it can be enabled and disabled even if not enabled by
    # plasma manager
    pkgs.polonium
  ];
}
