{ config, lib, pkgs, ... }:
let cfg = config.my.vr;
in {
  options.my.vr = {
    enable = lib.mkEnableOption "VR";
    programs.kaon.enable =
      lib.mkEnableOption "Kaon, a program that runs UEVR on Linux";
  };
  config = lib.mkIf cfg.enable {

    # Adds Kaon if enabled
    users.users.cubo.packages = lib.mkIf cfg.programs.kaon.enable [ pkgs.kaon ];

    # Enable monado for OpenXR
    # See more at https://wiki.nixos.org/wiki/VR#Monado
    services.monado = {
      enable = true;
      defaultRuntime = true; # Register as default OpenXR runtime
    };
    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };
    # For enabling hand tracking (should manage this with home manager later)
    # See more at https://wiki.nixos.org/wiki/VR#Hand_Tracking
    programs.git = {
      enable = lib.mkForce true;
      lfs.enable = lib.mkForce true;
      # Run:
      # mkdir -p ~/.local/share/monado
      # cd ~/.local/share/monado
      # git clone https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models
    };

    # Enable WiVRn for wireless VR
    # See more at https://wiki.nixos.org/wiki/VR#WiVRn
    services.wivrn = {
      enable = true;
      openFirewall = true;

      # Run WiVRn as a systemd service on startup
      autoStart = true;

      # You should use the default configuration (which is no configuration), as that works the best out of the box.
      # However, if you need to configure something see https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md for configuration options and https://mynixos.com/nixpkgs/option/services.wivrn.config.json for an example configuration.
    };

    # If you plan on playing OpenVR (not OpenXR) games in Proton, you'll need to
    # add environment variables to the command in Steam. 
    # A command example:
    # PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc %command%

  };
}
