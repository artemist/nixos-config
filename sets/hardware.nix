{ config, pkgs, ... }:

let
  openocd = if pkgs.stdenv.cc.isGNU then (pkgs.openocd.overrideAttrs ( old: {
    NIX_CFLAGS_COMPILE = old.NIX_CFLAGS_COMPILE ++ [ "-Wno-error=strict-prototypes" ];
  })) else pkgs.openocd;
in
  {
    services.udev.packages = [
      (pkgs.callPackage ../externals/rules/adafruit.nix { })
      (pkgs.callPackage ../externals/rules/limesuite.nix { })
      openocd
    ];

    environment.systemPackages = with pkgs; [
      kicad-unstable
      openocd
      stlink
      (callPackage ../externals/packages/jlink { })
    ];

    users = {
      users.artemis.extraGroups = [ "plugdev" "dialout" ];
      extraGroups.plugdev = {};
    };
  }
