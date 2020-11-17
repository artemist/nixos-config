{ config, pkgs, ... }:

{
  virtualisation = {
    docker.enable = true;
    lxd = {
      enable = true;
      recommendedSysctlSettings = true;
    };
  };

  users.users = {
    artemis.extraGroups = [ "docker" "lxd" ];
    root = {
      subUidRanges = [ { startUid = 16777216; count = 16777216; } { startUid = config.users.users.artemis.uid; count = 1; } ];
      subGidRanges = [ { startGid = 16777216; count = 16777216; } { startGid = 100; count = 1; } ];
    };
  };
}
