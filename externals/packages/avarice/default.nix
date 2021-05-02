{ lib, stdenv, fetchurl, perl, libbfd, libusb-compat-0_1, hidapi }:

stdenv.mkDerivation rec {
  pname = "avarice";
  version = "2.14";
  src = fetchurl {
    url = "mirror://sourceforge/project/avarice/avarice/avarice-${version}/avarice-${version}.tar.bz2";
    sha256 = "1ab2pxnkbw501iv1i9z9nj7hfzz4y7hid4l4q58cifm3aw17skjb";
  };

  nativeBuildInputs = [ perl ];
  buildInputs = [ libbfd libusb-compat-0_1 hidapi ];
  prePatch = ''
    find src -type f -name '*.cc' -exec sed -i "s@ __unused@@g" {} \;
  '';

  meta = with lib; {
    homepage = "http://avarice.sourceforge.net/";
    description = "A program to facilitate AVR debugging using an Atmel or AVR ICE";
    license = licenses.gpl2;
    platforms = platforms.unix;
    maintainers = [ maintainers.artemist ];
  };
}
