{ stdenv
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
  jlinkVersion = "690a";

  architecture = {
    x86_64-linux = "x86_64";
    i686-linux = "i386";
    armv7l-linux = "arm";
    aarch64-linux = "arm64";
  }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");

  sha256 = {
    x86_64-linux = "1cn51q1i6lapcz1xs28aa8gydvr3g25g78iwx11xgvp8bwaw0qws";
    i686-linux = "107zdzgsshq80r2sxkfrfw5vs5bnyvf1g8payhd1x91r4cr9f01z";
    armv7l-linux = "0wqf390kw0h3ysiw1i4dd10dmcll496673w41p685zln9xxypkmg";
    aarch64-linux = "1mw037245b44adkdcbg7xn9ng70chsfk0id8acc28hz43a92jb8n";
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

  meta = with stdenv.lib; {
    homepage = "https://www.segger.com/downloads/jlink";
    description = "SEGGER J-Link";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" "i686-linux" "armv7l-linux" "aarch64-linux" ];
    maintainers = with maintainers; [ artemist ];
  };
}
