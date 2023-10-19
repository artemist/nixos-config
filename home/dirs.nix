{ config, lib, ... }:

{
  xdg.userDirs = with lib; {
    enable = true;
    documents = mkDefault "${config.home.homeDirectory}/Dokumente";
    music = mkDefault "${config.home.homeDirectory}/Musik";
    pictures = mkDefault "${config.home.homeDirectory}/Bilder";
  };
}
