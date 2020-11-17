{ ... }:
{
  networking.networkmanager = {
    enable = true;
    ethernet.macAddress = "random";
    wifi.macAddress = "random";
  };
  users.users.artemis.extraGroups = [ "networkmanager" ];
}
