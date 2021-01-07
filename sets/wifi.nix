{ pkgs, ... }:
{
  networking.wireless.iwd.enable = true;
  services.udev.packages = [ pkgs.crda ];
  environment.etc."iwd/main.conf".text = ''
    [General]
    AddressRandomization=network
  '';
}
