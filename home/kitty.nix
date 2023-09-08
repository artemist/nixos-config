{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.fira-code;
      name = "FiraCode Nerd Font";
      size = 9;
    };
    settings = {
      update_check_interval = 0;
      close_on_child_death = true;
      confirm_os_window_close = 2;
      enable_audio_bell = 0;
      term = "kitty";
      clipboard_control = false;
      scrollback_lines = 32768;
      touch_scroll_multiplier = 4;
    };
  };
}
