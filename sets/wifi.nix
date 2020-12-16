{ ... }:
{
  networking.wireless.iwd.enable = true;
  environment.etc."iwd/main.conf".text = ''
    [General]
    AddressRandomization=network
  '';
}
