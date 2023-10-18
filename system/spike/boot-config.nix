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

  # This has to go in crypttab because we won't have the keyfile in the initrd
  environment.etc.crypttab.text = ''
    microsd /dev/disk/by-uuid/51ed9e97-06cf-4c54-a71a-c182bb0ced9e /var/lib/private/µsd_key
  '';
}
