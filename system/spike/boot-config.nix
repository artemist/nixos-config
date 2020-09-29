{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelPatches = [ {
      name = "increase_max_topo";
      patch = ../../externals/patches/increase_max_topo.patch;
    } ];
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "battery" ]; # wat
      luks.devices."${config.networking.hostName}" = {
        name = config.networking.hostName;
        device = "/dev/disk/by-uuid/9df93bae-80b9-48c2-be43-b73994afda5b";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
