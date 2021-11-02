{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.runAsRoot = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
  };

  # Breaks IPv4 on bridge
  boot.kernel.sysctl."net.bridge.bridge-nf-call-iptables" = 0;

  environment.systemPackages = with pkgs; [
    virtmanager
    spice_gtk
    cloud-hypervisor
    qemu
  ];

  users.users = {
    artemis.extraGroups = [ "docker" "lxd" "libvirtd" ];
    lxd = {
      isSystemUser = true;
      subUidRanges = [{ startUid = 16777216; count = 16777216; } { startUid = config.users.users.artemis.uid; count = 1; }];
      subGidRanges = [{ startGid = 16777216; count = 16777216; } { startGid = 100; count = 1; } { startGid = config.users.groups.artemis.gid; count = 1; }];
      group = "lxd";
    };
  };
}
