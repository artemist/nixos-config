{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPersist = "1h";
    controlPath = "~/.ssh/sockets/%r@%n:%p";
  };
}
