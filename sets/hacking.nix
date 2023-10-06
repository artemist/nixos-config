{ pkgs, ... }:

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
    nmap
    pwndbg
    python3Packages.binwalk-full

    fusee-launcher
  ];

  users.users.artemis.extraGroups = [ "adbusers" "wireshark" ];
}
