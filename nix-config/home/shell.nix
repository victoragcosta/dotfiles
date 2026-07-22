{ pkgs, ... }: {
  # Install fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    fira-code
  ];

  # Enable ZSH shell
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    setOptions = [ "EXTENDED_GLOB" ];
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    shellAliases = {
      neovide = "function _blah() { neovide --no-tabs -- \"$@\" 1>/dev/null 2>/dev/null & disown; }; _blah";
      # neovides = "neovide -S ./.session.vim";
      "cd.." = "cd ..";
      "cd." = "cd ..";
      ".." = "cd ..";
    };
  };
  programs.zsh.ohMyZsh = {
    enable = true;
  };
  environment.shells = [ pkgs.zsh ];
  environment.variables = {
    ZVM_SYSTEM_CLIPBOARD_ENABLED = "true";
  };

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cubo = {
    uid = 1000;
    isNormalUser = true;
    description = "Victor";
    extraGroups = [
      "networkmanager"
      "wheel"
      # uinput is needed for sunshine
      "uinput"
    ];
    shell = pkgs.zsh;
  };
}
