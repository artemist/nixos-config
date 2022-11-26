{ config, pkgs, pkgs-unstable, ... }:
let
  jlink = pkgs.callPackage ../externals/packages/jlink { };
in
{
  services.udev.packages = [
    (pkgs.callPackage ../externals/rules/adafruit.nix { })
    (pkgs.callPackage ../externals/rules/limesuite.nix { })
    pkgs.openocd
    pkgs.platformio
  ];

  environment.systemPackages = with pkgs; [
    kicad
    openocd
    picocom
    stlink
    jlink
    platformio
    pkgs-unstable.proxmark3-rrg
  ];

  users = {
    users.artemis.extraGroups = [ "plugdev" "dialout" ];
    extraGroups.plugdev = { };
  };
}
