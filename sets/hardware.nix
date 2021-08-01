{ config, pkgs, ... }:
let
  call = if (pkgs.targetPlatform.system == "x86_64-linux") then pkgs.pkgsi686Linux.callPackage else pkgs.callPackage;
  jlink = call ../externals/packages/jlink { };
in
{
  services.udev.packages = [
    (pkgs.callPackage ../externals/rules/adafruit.nix { })
    (pkgs.callPackage ../externals/rules/limesuite.nix { })
    pkgs.openocd
    pkgs.platformio
  ];

  environment.systemPackages = with pkgs; [
    kicad-unstable
    openocd
    picocom
    stlink
    jlink
    platformio
  ];

  users = {
    users.artemis.extraGroups = [ "plugdev" "dialout" ];
    extraGroups.plugdev = { };
  };
}
