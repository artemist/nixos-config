# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/galadriel/nixos";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/mapper/cryptboot";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptboot".device = "/dev/disk/by-uuid/716e31fa-6f96-46a8-8ec4-c7e0df34639f";

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/86D6-A42E";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/galadriel/home";
      fsType = "btrfs";
      options = [ "subvol=home" "user_subvol_rm_allowed" ];
    };

  fileSystems."/var/lib/flatpak" =
    { device = "/dev/galadriel/home";
      fsType = "btrfs";
      options = [ "subvol=flatpak" "user_subvol_rm_allowed" ];
    };

  fileSystems."/var/lib/docker" =
    { device = "/dev/galadriel/home";
      fsType = "btrfs";
      options = [ "subvol=docker" "user_subvol_rm_allowed" ];
    };

  fileSystems."/var/lib/lxd" =
    { device = "/dev/galadriel/home";
      fsType = "btrfs";
      options = [ "subvol=lxd" "user_subvol_rm_allowed" ];
    };

  swapDevices =
    [ { device = "/dev/galadriel/swap"; }
    ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

}
