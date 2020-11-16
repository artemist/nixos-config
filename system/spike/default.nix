{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../services/ssh.nix
    ../../sets/gpu/intel.nix
    ../../sets/cpu/intel.nix
    ../../sets/laptop.nix
  ];

  networking.hostName = "spike";
  services.avahi.publish.enable = true;
  system.stateVersion = "20.03";
}
