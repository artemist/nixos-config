{ config, pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."vm.swappiness" = 5;
    cleanTmpDir = true;

    initrd.luks = {
      devices = {
        galadriel = {
          name = "galadriel";
          device = "/dev/disk/by-uuid/5134c788-86dc-4f26-be5d-ed12187c2453";
          preLVM = true;
          keyFile = "/rootkey.bin";
          allowDiscards = true;
        };

        cryptboot = {
          keyFile = "/bootkey.bin";
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
