{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./secure-boot.nix
    ./hardware-configuration.nix
    ../../sets/gpu/intel.nix
    ../../sets/cpu/intel.nix
    ../../sets/laptop.nix
  ];

  networking.hostName = "rainbowdash";
  system.stateVersion = "20.03";
}
