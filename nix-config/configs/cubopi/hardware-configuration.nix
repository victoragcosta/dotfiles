{
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  # Use the mainline kernel supplied by the generic SD-image module. It is
  # available from the AArch64 binary cache, unlike the downstream Pi kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages;

  boot.initrd.availableKernelModules = [
    "usbhid"
    "usb_storage"
    "xhci_pci"
    "sd_mod"
    "mmc_block"
  ];

  # Transport used by the onboard Broadcom Bluetooth controller.
  boot.kernelModules = [ "hci_uart" ];

  # Provides the Raspberry Pi wireless/Bluetooth firmware on AArch64.
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # The Ethernet interface uses DHCP.
  networking.useDHCP = lib.mkDefault true;
}
