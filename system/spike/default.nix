{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../sets/cpu/intel.nix
    ../../sets/gpu/intel.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/sshd.nix
    ../../sets/buildMachines.nix
    ../../sets/workstation.nix
  ];

  networking.hostName = "spike";
  system.stateVersion = "20.03";
}
