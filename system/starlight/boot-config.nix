{ config, pkgs, ... }:
let
  net_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
  luna_opts = net_opts ++ [ "uid=${builtins.toString config.users.users.artemis.uid}" "gid=100" "credentials=/var/private/luna_creds" ];
in
{
  imports = [ ../../externals/systemd-boot-secure ];
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;
    loader.systemd-boot-secure = {
      enable = true;
      signed = true;
      signing-key = "/root/secure-boot/db.key";
      signing-certificate = "/root/secure-boot/db.crt";
    };

    # Device fails with uas
    kernelParams = [ "usb-storage.quirks=152d:0578:u" ];

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
          device = "/dev/disk/by-uuid/43220fc3-2f33-4915-9365-59eb27b21719";
          preLVM = true;
          allowDiscards = true;
        };
      };
    };
  };

  fileSystems."/media/luna/media".options = net_opts;
  fileSystems."/media/luna/photos".options = net_opts;
  fileSystems."/media/luna/games".options = net_opts;
  fileSystems."/media/luna/private".options = luna_opts;
}
