{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      slang = "eng,en";
      alang = "eng,en";
      hwdec = "vaapi";
      vo = "gpu";

      audio-display = "no";
      audio-normalize-downmix = "yes";
      replaygain = "track";
    };
    # Don't make this profile default since not all machines can handle it
    profiles.gpu-hq = {
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
    };

    # 1.5 times speed, ≈702 cents pitch up
    profiles.wat = {
      speed = "1.5";
      audio-pitch-correction = "no";
    };

    bindings = {
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      WHEEL_LEFT = "ignore";
      WHEEL_RIGHT = "ignore";
      k = "add sub-scale -0.1";
      K = "add sub-scale +0.1";
      "[" = "add speed -0.1";
      "]" = "add speed 0.1";
      "{" = "add speed -1";
      "}" = "add speed 1";
    };
  };
}
