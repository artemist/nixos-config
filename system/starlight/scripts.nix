{ pkgs, lib, ... }:
let
  swayPrelude = ''
    #! ${pkgs.runtimeShell}
    PATH=${pkgs.sway}/bin
  '';
in {
  home-manager.users.artemis.home.packages = [
    (pkgs.writeScriptBin "work" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 2 pos 0 0"
      swaymsg "output DP-2 disable"
      swaymsg "output DP-3 disable"
    '')
    (pkgs.writeScriptBin "miniwork" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 2 pos 0 0"
      swaymsg "output DP-2 enable mode 3840x2160 scale 2 pos 1920 0"
      swaymsg "output DP-3 disable"
    '')
    (pkgs.writeScriptBin "game" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 2 pos 0 0"
      swaymsg "output DP-2 enable mode 3840x2160 scale 1 pos 1920 0"
      swaymsg "output DP-3 enable mode 3840x2160 scale 2 pos 5760 0"
    '')
    (pkgs.writeScriptBin "nogame" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 2 pos 0 0"
      swaymsg "output DP-2 enable mode 3840x2160 scale 2 pos 1920 0"
      swaymsg "output DP-3 enable mode 3840x2160 scale 2 pos 3840 0"
    '')
    (pkgs.writeScriptBin "swap" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 2 pos 1920 0"
      swaymsg "output DP-2 enable mode 3840x2160 scale 2 pos 0 0"
      swaymsg "output DP-3 enable mode 3840x2160 scale 2 pos 3840 0"
    '')
    (pkgs.writeScriptBin "swapgame" ''
      ${swayPrelude}
      swaymsg "output DP-1 enable mode 3840x2160 scale 1 pos 0 0"
      swaymsg "output DP-2 enable mode 3840x2160 scale 2 pos 3840 0"
      swaymsg "output DP-3 enable mode 3840x2160 scale 2 pos 5760 0"
    '')
  ];
}
