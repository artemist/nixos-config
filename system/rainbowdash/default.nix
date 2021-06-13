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
  ];

  networking.hostName = "rainbowdash";
  system.stateVersion = "20.03";
}
