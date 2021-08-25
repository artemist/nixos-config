{ config, pkgs, ... }:

{
  boot = {
    kernel.sysctl."vm.swappiness" = 5;
    kernelPackages = pkgs.linuxPackages_pinebookpro_lts;
    cleanTmpDir = true;
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
  };

  fileSystems = {
    "/boot".options = [ "noatime" ];
    "/".options = [ "noatime" ];
  };
}
