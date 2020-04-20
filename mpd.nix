{ config, pkgs, ... }:

{
  services = {
    mpd = {
      enable = true;
      startWhenNeeded = true;
      network.listenAddress = "any";
      dataDir = "/data/var/mpd";
      musicDirectory = "/data/Musik";
    };
    ympd.enable = true;
  };
}
