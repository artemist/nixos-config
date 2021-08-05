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
    pwndbg
    python3Packages.binwalk-full
    python3Packages.shodan
  ];

  users.users.artemis.extraGroups = [ "adbusers" "wireshark" ];
}
