{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cyanrip makemkv ];

  # Needed for MakeMKV
  boot.kernelModules = [ "sg" ];

  users.users.artemis.extraGroups = [ "cdrom" ];
}
