{ pkgs, inputs, ... }:

{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot.loader.systemd-boot.enable = false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
