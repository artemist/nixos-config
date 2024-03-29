{ pkgs, ... }: {
  services.udev.packages = [ pkgs.crda ];
  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "stable";
  };
  users.users.artemis.extraGroups = [ "networkmanager" ];
}
