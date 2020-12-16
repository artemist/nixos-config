{ config, pkgs, ... }:

{
  imports = [
    ./boot-config.nix
    ./hardware-configuration.nix
    ../../externals/wip-pinebook-pro/pinebook_pro.nix
    ../../sets/neovim
    ../../sets/sway.nix
    ../../sets/wifi.nix
  ];

  networking.hostName = "mistmane";
  programs.light.enable = true;
  system.stateVersion = "20.09";

  environment.systemPackages = with pkgs; [
    foot
  ];
}
