{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.crda ];
  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "random";
  };
  users.users.artemis.extraGroups = [ "networkmanager" ];
}
