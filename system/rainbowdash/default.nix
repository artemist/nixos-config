{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./secure-boot.nix
    ./hardware-configuration.nix
    ../../sets/cpu/intel.nix
    ../../sets/gpu/intel.nix
    ../../sets/buildMachines.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/1password.nix
    ../../sets/workstation.nix
    ../../sets/krb5.nix
  ];

  environment.systemPackages = [
    pkgs.pkgsCross.aarch64-multiplatform.buildPackages.gcc
  ];

  boot.supportedFilesystems = [ "nfs4" ];

  networking.domain = "manehattan.artem.ist";
  networking.hostName = "rainbowdash";
  system.stateVersion = "20.03";
}
