{ pkgs, ... }:
{
  # Install fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["FiraCode"]; })
    fira-code
  ];

  # Enable ZSH shell
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  programs.zsh.ohMyZsh = {
    enable = true;
  };
  environment.shells = [ pkgs.zsh ];

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cubo = {
    isNormalUser = true;
    description = "Victor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
}
