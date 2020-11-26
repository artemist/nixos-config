{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gr-limesdr
    limesuite
    gnuradio-with-packages
    soapysdr
    gqrx
  ];
}
