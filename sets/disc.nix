{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cyanrip
    makemkv
  ];

  users.users.artemis.extraGroups = [ "cdrom" ];
}
