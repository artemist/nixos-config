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
    ../../sets/neovim
    ../../sets/pipewire.nix
    ../../sets/sway.nix
  ];

  networking.hostName = "rainbowdash";
  system.stateVersion = "20.03";
}
