{ config, pkgs, ... }:

let
  wofi = pkgs.wofi.overrideAttrs ( old: {
    src = pkgs.fetchhg {
      url = old.src.url;
      rev = "e3db9b8075e71399bba14a568c59032f47981dab";
      sha256 = "07fr1yfls94gxpwv3azgzxm7shjs4g5ribvqrh88flpf4cv5hq2d";
    };
  } );
in
  {
    security.polkit.enable = true;
    services = {
      accounts-daemon.enable = true;
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
      wf-recorder
      wl-clipboard
      wofi
      xdg-user-dirs
      xdg_utils
      xsettingsd
    ];
  }

