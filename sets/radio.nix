{ config, pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    soapysdr-with-plugins
  ];
  environment.systemPackages = with pkgs; [
    soapysdr-with-plugins
    gqrx
  ];
}
