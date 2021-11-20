{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.crda ];
  networking.wireless.iwd = {
    enable = true;
    settings.General.AddressRandomization = "network";
  };
}
