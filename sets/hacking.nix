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
    apktool
    aircrack-ng
    nmap
    pwndbg
    python3Packages.binwalk-full

    fusee-launcher
    hactool
  ];

  users.users.artemis.extraGroups = [ "adbusers" "wireshark" ];
}
