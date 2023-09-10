{ pkgs, inputs, ... }:

{
  fonts = {
    fontconfig.enable = true;
    fontconfig.localConf = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <match target="font">
          <test name="family">
            <string>Inter</string>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>tnum on</string>
            <string>cv03 on</string>
            <string>cv04 on</string>
            <string>cv08 on</string>
          </edit>
        </match>
        <match target="font">
          <test name="family">
            <string>Fira Code</string>
          </test>
          <edit name="fontfeatures" mode="append">
            <string>cv06 on</string>
            <string>ss02 on</string>
            <string>ss04 on</string>
          </edit>
        </match>
      </fontconfig>
    '';

    enableDefaultPackages = true;
    packages = with pkgs;
      [
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
        roboto

        # Large multilingual fonts
        fira-go
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra

        # Weird symbols
        (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      ] ++ (builtins.attrValues inputs.fonts.packages.${pkgs.system});
  };
}
