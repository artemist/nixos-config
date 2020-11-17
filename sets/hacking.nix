{ config, pkgs, ... }:

{
  programs = {
    adb.enable = true;
    wireshark = {
      enable = true;
      package = pkgs.wireshark-qt;
    };
  };
  environment.systemPackages = with pkgs; [
    aircrack-ng
    fusee-launcher
    ncat
    pcsctools
    pwndbg
    python37Packages.binwalk-full
    python37Packages.shodan
  ];

  users.users.artemis.extraGroups = [ "adbusers" "wireshark" ];
}
