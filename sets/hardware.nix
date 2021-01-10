{ config, pkgs, ... }:
let
  jlink = pkgs.callPackage ../externals/packages/jlink { };
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
