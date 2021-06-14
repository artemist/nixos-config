{ stdenv
, lib
, fetchurl
, autoPatchelfHook
, substituteAll
, qt4
, fontconfig
, freetype
, libusb
, libICE
, libSM
, ncurses5
, udev
, libX11
, libXext
, libXcursor
, libXfixes
, libXrender
, libXrandr
}:
let
  jlinkVersion = "700a";

  architecture = {
    x86_64-linux = "x86_64";
    i686-linux = "i386";
    armv7l-linux = "arm";
    aarch64-linux = "arm64";
  }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");

  sha256 = {
    x86_64-linux = "0b9jyhd0lkd0icabpfgdcbmzdz4arw1wvjkzchbm4gpd4lvw5q0g";
    i686-linux = "0dam6v4gxc0jbhw3ab73jw9v8m166wxy07blfb53gq8xpl71x0f9";
    armv7l-linux = "1ihcs0pxd28ay7v5c5kc6v28n9wml1s6p94b8lcxyddjli3lpkly";
    aarch64-linux = "1pr1ziksixjrryhiycyl4qbr7fjnpgkj00iyphapxqcd0b64hsyr";
  }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");

  url = "https://www.segger.com/downloads/jlink/JLink_Linux_V${jlinkVersion}_${architecture}.tgz";
in
stdenv.mkDerivation rec {
  pname = "jlink";
  version = jlinkVersion;

  src = fetchurl {
    url = url;
    sha256 = sha256;
    curlOpts = "-d accept_license_agreement=accepted -d non_emb_ctr=confirmed";
  };

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    qt4
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
    rm -r $out/bin/JLinkDevices.xml $out/JLink/libQt*
    install -D -t $out/lib/udev/rules.d 99-jlink.rules
  '';

  preFixup = ''
    patchelf --add-needed libudev.so.1 $out/JLink/libjlinkarm.so
  '';

  meta = with lib; {
    homepage = "https://www.segger.com/downloads/jlink";
    description = "SEGGER J-Link";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" "i686-linux" "armv7l-linux" "aarch64-linux" ];
    maintainers = with maintainers; [ artemist ];
  };
}
