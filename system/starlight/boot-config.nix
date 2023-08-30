{ config, pkgs, ... }:
let
  net_opts = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=5s"
  ];
in {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernel.sysctl."vm.swappiness" = 5;
    tmp.cleanOnBoot = true;

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
  fileSystems."/media/luna/private".options = net_opts;

  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/" "/media/data" ];
  };
}
