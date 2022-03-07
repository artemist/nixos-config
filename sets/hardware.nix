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
    pkgs.saleae-logic-2
  ];

  environment.systemPackages = with pkgs; [
#    pkgs-unstable.kicad
    openocd
    picocom
    stlink
    jlink
    platformio
    saleae-logic-2
  ];

  users = {
    users.artemis.extraGroups = [ "plugdev" "dialout" ];
    extraGroups.plugdev = { };
  };
}
