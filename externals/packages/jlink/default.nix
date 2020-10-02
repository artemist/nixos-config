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
  jlinkVersion = "686a";

  architecture = {
    x86_64-linux = "x86_64";
    i686-linux = "i386";
    armv7l-linux = "arm";
    aarch64-linux = "arm64";
  }.${stdenv.hostPlatform.system} or (throw "unsupported system ${stdenv.hostPlatform.system}");

  sha256 = {
    x86_64-linux = "1avwxlyr9aay1wrpjgqahwgmsjb5vp8h2pdxsr2gb3rj3mlx7r56";
    i686-linux = "13rldsryi56yx5172v0s0vlwdrxd96lfzj8i8v14sn64ziqh7wdb";
    armv7l-linux = "1j8p8kz3nx965xbh6d8wxmrm0xp9p7ryda07iak0d3bslq78ifvs";
    aarch64-linux = "1ivwndpql05hiv08mbff75ysbg5fn18islsc1gcqz8a8hbx0jw44";
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
