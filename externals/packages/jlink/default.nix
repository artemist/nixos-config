{ stdenv, lib, fetchurl, autoPatchelfHook, fontconfig, freetype, libusb, libICE
, libSM, ncurses5, udev, libX11, libXext, libXcursor, libXfixes, libXrender
, libXrandr }:
let
  conf = (lib.importJSON ./version.json).${stdenv.hostPlatform.system} or (throw
    "unsupported system ${stdenv.hostPlatform.system}");
in stdenv.mkDerivation rec {
  pname = "jlink";
  version = conf.version;

  src = fetchurl { inherit (conf) url hash curlOpts; };

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;
  preferLocalBuild = true;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    fontconfig
    freetype
    libusb
    libICE
    libSM
    ncurses5
    udev
    libX11
    libXext
    libXcursor
    libXfixes
    libXrender
    libXrandr
  ];

  runtimeDependencies = [ udev ];

  installPhase = ''
    mkdir -p $out/{JLink,bin}
    cp -R * $out/JLink
    ln -s $out/JLink/J* $out/bin/
    install -D -t $out/lib/udev/rules.d 99-jlink.rules
  '';

  preFixup = ''
    patchelf --add-needed libudev.so.1 $out/JLink/libjlinkarm.so
  '';

  passthru.updateScript = ./update.py;

  meta = with lib; {
    homepage = "https://www.segger.com/downloads/jlink";
    description = "SEGGER J-Link";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" "i686-linux" "armv7l-linux" "aarch64-linux" ];
    maintainers = with maintainers; [ artemist ];
  };
}
