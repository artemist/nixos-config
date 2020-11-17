{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../sets/cpu/intel.nix
    ../../sets/gpu/intel.nix
    ../../sets/hacking.nix
    ../../sets/laptop.nix
    ../../sets/neovim
    ../../sets/ssh.nix
    ../../sets/sway.nix
  ];

  networking.hostName = "spike";
  services.avahi.publish.enable = true;
  system.stateVersion = "20.03";
}
