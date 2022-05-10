{ config, pkgs, inputs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/sshd.nix
    ../../sets/buildMachines.nix
    ../../sets/workstation.nix
    inputs.nixos-hardware.nixosModules.gpd-micropc
  ];

  networking.hostName = "spike";
  system.stateVersion = "20.03";
}
