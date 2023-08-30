{ config, pkgs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      # MS fonts
      cantarell-fonts
      corefonts

      # Mono fonts
      dejavu_fonts
      fira-code
      iosevka
      source-code-pro
      source-sans-pro

      # UI fonts
      b612
      inter
      inter-ui
      roboto

      # All the noto
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
    ];
  };
}
