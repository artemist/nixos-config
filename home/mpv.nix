{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      slang = "eng,en";
      alang = "eng,en";
      hwdec = "vaapi";
      vo = "gpu";

      no-audio-display = "";
      audio-normalize-downmix = "";
      replaygain = "track";
    };
    # Don't make this profile default since not all machines can handle it
    profiles.gpu-hq = {
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
    };

    bindings = {
      WHEEL_UP = "ignore";
      WHEEL_DOWN = "ignore";
      WHEEL_LEFT = "ignore";
      WHEEL_RIGHT = "ignore";
      k = "add sub-scale -0.1";
      K = "add sub-scale +0.1";
    };
  };
}
