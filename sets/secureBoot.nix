{ pkgs, inputs, ... }:

{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot.loader.systemd-boot.enable = false;

  environment.systemPackages = [ pkgs.sbctl ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };
}
