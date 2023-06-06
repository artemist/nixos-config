{ config, pkgs, pkgs-unstable, ... }:

{
  boot = {
    kernelPackages = pkgs-unstable.linuxPackages_latest;
    kernelParams = [ "fbcon=rotate:1" ];
    kernel.sysctl."vm.swappiness" = 5;
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      luks.devices."${config.networking.hostName}" = {
        name = config.networking.hostName;
        device = "/dev/disk/by-uuid/eb0e5aaf-afa3-43e4-89b3-af4a3f7f0546";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
}
