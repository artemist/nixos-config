{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../externals/wip-pinebook-pro/pinebook_pro.nix
    ../../sets/wifi.nix
    ../../sets/workstation.nix
  ];

  networking.hostName = "mistmane";
  programs.light.enable = true;
  system.stateVersion = "20.09";

  environment.systemPackages = with pkgs; [
    foot
  ];
}
