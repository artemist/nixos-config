# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/8b204d52-62c1-48e9-b487-e7138f49903a";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/375e4660-be08-40ba-8961-0a9cc3a96187";
    fsType = "ext4";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/1114039c-3329-4551-a56d-fccde77a31a7"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
