{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl."vm.swappiness" = 5;
    kernelParams = [ "console=tty1" ];
    cleanTmpDir = true;
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    initrd.luks.devices."${config.networking.hostName}" = {
      name = config.networking.hostName;
      device = "/dev/disk/by-uuid/74b7cded-e9f8-432f-b694-5bea09635168";
      preLVM = true;
      allowDiscards = true;
    };
  };

  fileSystems = {
    "/boot".options = [ "noatime" ];
    "/".options = [ "noatime" ];
  };
}
