{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fcitx5 # input method framework
    fcitx5-mozc # Japanese input method
    kdePackages.fcitx5-configtool # for configuring input methods
  ];
}
