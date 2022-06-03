{ config, pkgs, ... }:

{
  imports = [
    ./wifi.nix
  ];

  services.upower.enable = true;
  programs.light.enable = true;
  users.users.artemis.extraGroups = [ "video" ];

  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.cpupower
  ];
}
