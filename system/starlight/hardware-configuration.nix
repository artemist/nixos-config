# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/aca21111-a488-4bc7-90a7-e61517c24818";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/aca21111-a488-4bc7-90a7-e61517c24818";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/1AC2-9317";
      fsType = "vfat";
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/aca21111-a488-4bc7-90a7-e61517c24818";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/media/data" =
    {
      device = "/dev/disk/by-uuid/c01b98d1-1eb9-42ce-8d05-4b9d852fca55";
      fsType = "btrfs";
    };

  fileSystems."/var/lib/lxd/shmounts" =
    {
      device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/var/lib/lxd/devlxd" =
    {
      device = "tmpfs";
      fsType = "tmpfs";
    };

  fileSystems."/var/lib/lxd/storage-pools/default" =
    {
      device = "/dev/disk/by-uuid/aca21111-a488-4bc7-90a7-e61517c24818";
      fsType = "btrfs";
      options = [ "subvol=root/var/lib/lxd/storage-pools/default" ];
    };

  fileSystems."/media/luna/photos" =
    {
      device = "10.69.0.69:/media/tank/photos";
      fsType = "nfs4";
    };

  fileSystems."/media/luna/games" =
    {
      device = "10.69.0.69:/media/tank/games";
      fsType = "nfs4";
    };

  fileSystems."/media/luna/media" =
    {
      device = "10.69.0.69:/media/tank/media";
      fsType = "nfs4";
    };

  fileSystems."/media/luna/private" =
    {
      device = "10.69.0.69:/media/tank/users/artemis";
      fsType = "nfs4";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/b134fecf-719f-45af-b317-001e413f06c4"; }];

}
