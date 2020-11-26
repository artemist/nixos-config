{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;
    blacklistedKernelModules = [ "psmouse" ];

    initrd = {
      luks.devices."${config.networking.hostName}" = {
        name = config.networking.hostName;
        device = "/dev/disk/by-uuid/e8a47693-e6d9-4d66-ac8a-13633e606f3d";
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
