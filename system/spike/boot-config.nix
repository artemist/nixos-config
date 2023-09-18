{ lib, ... }:

{
  boot = {
    kernelParams = [ "fbcon=rotate:1" ];
    kernel.sysctl."vm.swappiness" = 5;
    tmp.cleanOnBoot = true;
  };

  swapDevices = lib.mkForce [{
    device = "/dev/disk/by-partuuid/ef7cb78c-a07d-45e2-a92a-0f041c42f07a";
    randomEncryption = {
      enable = true;
      allowDiscards = true;
    };
  }];
}
