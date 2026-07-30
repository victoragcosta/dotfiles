{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.libinput.enable = lib.mkDefault true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.sensor.iio.enable = true;
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    # NOTE: unmaintained
    # maliit-keyboard
    kdePackages.qtsensors
    kdePackages.qtvirtualkeyboard
  ];
  # TODO: add automatically switching between fcitx5 and plasma-keyboard
  # Base it on this article https://unnamed.website/posts/switch-virtual-keyboard/
}
