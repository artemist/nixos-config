{ config, pkgs, ... }:
{
  imports = [ ./fonts.nix ];
  security.polkit.enable = true;
  services = {
    accounts-daemon.enable = true;
    logind.lidSwitch = "suspend";
    logind.extraConfig = "HandlePowerKey=suspend";
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
  sound.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export MOZ_USE_XINPUT2=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      export GTK_THEME=Adwaita-dark
    '';
  };
  environment.systemPackages = with pkgs; [
    dex
    glib
    grim
    imagemagick
    libnotify
    mako
    polkit_gnome
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    wofi
    xdg-user-dirs
    xdg_utils
    xsettingsd
  ];
}
