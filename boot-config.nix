{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;

    initrd.luks = {
      devices = {
        "${config.networking.hostName}" = {
          name = config.networking.hostName;
          device = "/dev/disk/by-uuid/e8a47693-e6d9-4d66-ac8a-13633e606f3d";
          preLVM = true;
          keyFile = "/key.bin";
          allowDiscards = true;
        };

        boot = {
          keyFile = "/key.bin";
          allowDiscards = true;
        };
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        device = "nodev";
        version = 2;
        efiSupport = true;
        enableCryptodisk = true;
        extraInitrd = /boot/initrd.keys.gz;
      };
    };
  };

  services.udev = {
    packages = [
      pkgs.android-udev-rules
      pkgs.openocd
      (pkgs.callPackage ./externals/rules/adafruit.nix { })
      (pkgs.callPackage ./externals/rules/fpga.nix { })
      (pkgs.callPackage ./externals/rules/limesuite.nix { })
      (pkgs.callPackage ./externals/rules/uhk.nix { })
    ];
  };

  fileSystems = {
    "/home".options = ["noatime"];
    "/boot".options = ["noatime"];
    "/".options = ["noatime"];
  };
}
