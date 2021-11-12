{ pkgs, lib, config, ... }:
let
  rustybar = pkgs.callPackage ../externals/packages/rustybar { };
  sway-scripts = pkgs.callPackage ../externals/packages/sway-scripts { };
  cfg = config.wayland.windowManager.sway;
  mod = cfg.config.modifier;
  extraWorkspaces = {
    F1 = "11 Firefox";
    F2 = "12 Music";
    F3 = "13";
    F4 = "14";
    F5 = "15";
    F6 = "16 Telegram";
    F7 = "17 Chat";
    F8 = "18 Signal";
    F9 = "19";
    F10 = "20 IRC";
    F11 = "21";
    F12 = "22";
  };
  extraGotoBindings = lib.mapAttrs'
    (name: value: {
      name = "${mod}+${name}";
      value = "workspace ${value}";
    })
    extraWorkspaces;
  extraMoveBindings = lib.mapAttrs'
    (name: value: {
      name = "${mod}+Shift+${name}";
      value = "move container to workspace ${value}";
    })
    extraWorkspaces;
in
{
  home.packages = [ sway-scripts ];
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export MOZ_USE_XINPUT2=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      export GTK_THEME=Adwaita-dark
    '';
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "wofi -i -S run";

      fonts = {
        names = [ "Inter" ];
        size = 8.0;
      };

      gaps.inner = 4;

      input."*" = {
        natural_scroll = "yes";
        xkb_options = "compose:caps";
      };
      output."*".bg = "${./files/sicily.jpg} fill";

      startup = [
        { command = "mako"; }
        { command = "dbus-update-activation-environment --systemd --all"; always = true; }
        { command = "swayidle -w before-sleep 'swaylock -f' timeout 600 'swaylock -f' timeout 1200 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"'"; }
      ];

      # I have to set these to something and can't set them to existing uses
      left = "Mod1+Left";
      down = "Mod1+Down";
      up = "Mod1+Up";
      right = "Mod1+Right";
      keybindings = lib.mkOptionDefault
        ({
          "${mod}+Shift+d" = "exec wofi -I -i -S drun";
          "${mod}+j" = "move workspace to left";
          "${mod}+k" = "move workspace to right";
          "${mod}+l" = "exec swaylock";
          "${mod}+Mod1+e" = "exec wofi-emoji";
          # Sink 0 means the default AIUI
          "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%";
          "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%";
          "XF86AudioMute" = "exec pactl set-sink-mute 0 toggle";
          "XF86MonBrightnessUp" = "exec light -A 5";
          "XF86MonBrightnessDown" = "exec light -U 5";
          "Print" = "exec grim \"$(xdg-user-dir PICTURES)/Screenshot/$(date +'%F %H-%M-%S-%N_screenshot.png')\"";
          "Shift+Print" = "exec grim -g \"$(slurp)\" \"$(xdg-user-dir PICTURES)/Screenshot/$(date +'%F %H-%M-%S-%N_screenshot.png')\"";
        } // extraGotoBindings // extraMoveBindings);

      floating.titlebar = true;
      window.titlebar = true;

      bars = [{
        statusCommand = "${rustybar}/bin/rustybar";
        position = "top";
        fonts = cfg.config.fonts;
        colors = {
          background = "#000000d0";
          statusline = "#ffffff";
          separator = "#aaaaaa";
          inactiveWorkspace = { border = "#000000d0"; background = "#323232d0"; text = "#ffffffd0"; };
        };
      }];
    };
  };
}