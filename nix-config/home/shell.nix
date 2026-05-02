{ pkgs, ... }: {
  # Install fonts
  fonts.packages = with pkgs; [ nerd-fonts.fira-code fira-code ];

  # Enable ZSH shell
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
  };
  programs.zsh.ohMyZsh = { enable = true; };
  environment.shells = [ pkgs.zsh ];
  environment.variables = { ZVM_SYSTEM_CLIPBOARD_ENABLED = "true"; };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cubo = {
    uid = 1000;
    isNormalUser = true;
    description = "Victor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
