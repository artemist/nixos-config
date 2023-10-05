{ config, pkgs, ... }: {
  imports = [ ./fonts.nix ];
  security.polkit.enable = true;
  services = {
    accounts-daemon.enable = true;
    logind.lidSwitch = "suspend";
    logind.extraConfig = "HandlePowerKey=suspend";
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };
  sound.enable = true;
  environment.systemPackages = with pkgs; [
    dex
    glib
    grim
    imagemagick
    libnotify
    mako
    polkit_gnome
    slurp
    swayidle
    swaylock
    waypipe
    wf-recorder
    wl-clipboard
    wofi
    wofi-emoji
    wtype
    xdg-user-dirs
    xdg_utils
    xsettingsd
  ];

  hardware.opengl.enable = true;
  security.pam.services.swaylock = { };
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  home-manager.users.artemis.imports = [ ../home/sway.nix ];
}
