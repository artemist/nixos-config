{ config, pkgs, ... }:
let
  oldpkgs = import (fetchTarball "http://nixos.org/channels/nixos-20.03/nixexprs.tar.xz") { config.allowUnfree = true; };
  jlink = oldpkgs.callPackage ../externals/packages/jlink { };
in
{
  services.udev.packages = [
    (pkgs.callPackage ../externals/rules/adafruit.nix { })
    (pkgs.callPackage ../externals/rules/limesuite.nix { })
    pkgs.openocd
  ];

  environment.systemPackages = with pkgs; [
    kicad-unstable
    openocd
    picocom
    stlink
    jlink
  ];

  users = {
    users.artemis.extraGroups = [ "plugdev" "dialout" ];
    extraGroups.plugdev = { };
  };
}
