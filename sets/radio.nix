{ config, pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    limesuite
  ];
  environment.systemPackages = with pkgs; [
    limesuite
    soapysdr
    gqrx
  ];
}
