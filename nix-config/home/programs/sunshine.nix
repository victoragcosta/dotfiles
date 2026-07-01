{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.sunshine;
in
{
  options.services.sunshine.switch-screen = lib.mkEnableOption "Switch screen when running a sunshine app";
  config = lib.mkIf config.services.sunshine.enable (
    let
      # An easier way to call the service below
      steam-run-url = pkgs.writeShellApplication {
        name = "steam-run-url";
        text = ''
          echo "$1" > "/run/user/${builtins.toString config.users.users.cubo.uid}/steam-run-url.fifo"
        '';
        # runtimeInputs = [
        #   pkgs.coreutils # For `id` command
        # ];
      };
    in
    {
      programs.steam.enable = lib.mkForce true;

      # For game streaming to moolight
      services.sunshine = {
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        settings = {
          back_button_timeout = 2000;
          global_prep_cmd = lib.mkIf cfg.switch-screen (
            builtins.toJSON [
              {
                do = "kscreen-doctor output.HDMI-A-1.enable output.DP-3.disable";
                undo = "kscreen-doctor output.DP-3.enable output.HDMI-A-1.disable";
              }
            ]
          );
        };
        applications = {
          env = {
            PATH = "$(PATH):$(HOME)/.local/bin";
          };
          apps = [
            {
              name = "Desktop";
              image-path = "desktop.png";
            }
            {
              name = "Steam Big Picture";
              prep-cmd = [
                {
                  do = "steam-run-url steam://open/bigpicture";
                  undo = "steam-run-url steam://close/bigpicture";
                }
              ];
              image-path = "steam.png";
            }
          ];
        };
      };

      # A service used to fix steam not starting when running from sunshine
      # See https://discourse.nixos.org/t/sunshine-self-hosted-game-stream/25608/24
      systemd.user.services.steam-run-url-service = {
        enable = true;
        description = "Listen and starts steam games by id";
        wantedBy = [ "default.target" ];
        partOf = [ "default.target" ];
        wants = [ "default.target" ];
        after = [ "default.target" ];
        serviceConfig.Restart = "on-failure";
        script = toString (
          pkgs.writers.writePython3 "steam-run-url-service" { } ''
            import os
            from pathlib import Path
            import subprocess

            pipe_path = Path(f'/run/user/{os.getuid()}/steam-run-url.fifo')
            try:
                pipe_path.parent.mkdir(parents=True, exist_ok=True)
                pipe_path.unlink(missing_ok=True)
                os.mkfifo(pipe_path, 0o600)
                steam_env = os.environ.copy()
                steam_env["QT_QPA_PLATFORM"] = "wayland"
                while True:
                    with pipe_path.open(encoding='utf-8') as pipe:
                        subprocess.Popen(['steam', pipe.read().strip()], env=steam_env)
            finally:
                pipe_path.unlink(missing_ok=True)
          ''
        );
        path = [
          pkgs.gamemode
          pkgs.steam
        ];
      };

      # Allow running `steam-run-url` from shell for testing purposes
      environment.systemPackages = [ steam-run-url ];

      # Allow running `steam-run-url` from Sunshine without knowing the script's
      # absolute file path
      systemd.user.services.sunshine.path = [ steam-run-url ];
    }
  );

}
