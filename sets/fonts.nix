{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [
      cantarell-fonts
      corefonts
      dejavu_fonts
      fira-code
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      source-code-pro
      source-sans-pro
    ];
  };
}
