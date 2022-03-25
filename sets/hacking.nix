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
    ncat
    pwndbg
    python3Packages.binwalk-full
  ];

  users.users.artemis.extraGroups = [ "adbusers" "wireshark" ];
}
