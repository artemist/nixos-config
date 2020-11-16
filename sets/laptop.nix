{ config, pkgs, ... }:

{
  services = {
    tlp.enable = true;
    upower.enable = true;
  };
  programs.light.enable = true;
  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.cpupower
  ];
}
