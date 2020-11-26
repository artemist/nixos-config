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

    # Encrypted drives
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
}
