{ config, pkgs, ... }:
let jlink = pkgs.callPackage ../externals/packages/jlink { };
in {
  services.udev.packages = [
    (pkgs.callPackage ../externals/rules/adafruit.nix { })
    (pkgs.callPackage ../externals/rules/limesuite.nix { })
    pkgs.libsigrok
    pkgs.openocd
    pkgs.platformio
  ];

  environment.systemPackages = with pkgs; [
    jlink
    kicad
    openocd
    picocom
    platformio
    proxmark3-rrg
    pulseview
    stlink
  ];

  users = {
    users.artemis.extraGroups = [ "plugdev" "dialout" ];
    extraGroups.plugdev = { };
  };
}
