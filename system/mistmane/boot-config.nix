{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;

    initrd = {
      luks.devices."${config.networking.hostName}" = {
        name = config.networking.hostName;
        device = "/dev/disk/by-uuid/aa3cac7f-695a-40d4-ad2b-f781ddd3c8e1";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };

  fileSystems = {
    "/home".options = [ "noatime" ];
    "/boot".options = [ "noatime" ];
    "/".options = [ "noatime" ];
  };
}
