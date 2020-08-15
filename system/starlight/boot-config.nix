{ config, pkgs, ... }:

{
  imports = [ ../../externals/systemd-boot-secure ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;
    loader.systemd-boot-secure = {
      enable = true;
      signed = true;
      signing-key = "/root/secure-boot/db.key";
      signing-certificate = "/root/secure-boot/db.crt";
    };

    initrd.luks = {
      reusePassphrases = true;
      devices = {
        "${config.networking.hostName}" = {
          device = "/dev/disk/by-uuid/274ec302-20b7-43bf-aa72-895ffdd96919";
          preLVM = true;
          allowDiscards = true;
        };
        glimmer = {
          preLVM = true;
          allowDiscards = true;
        };
      };
    };
  };

  services.udev = {
    packages = [
      pkgs.android-udev-rules
      pkgs.openocd
      (pkgs.callPackage ../../externals/rules/adafruit.nix { })
      (pkgs.callPackage ../../externals/rules/ds4drv.nix { })
      (pkgs.callPackage ../../externals/rules/fpga.nix { })
      (pkgs.callPackage ../../externals/rules/limesuite.nix { })
      (pkgs.callPackage ../../externals/rules/cm-rgb.nix { })
      (pkgs.callPackage ../../externals/rules/uhk.nix { })
    ];
  };
}
