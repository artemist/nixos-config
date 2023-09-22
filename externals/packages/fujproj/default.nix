{ stdenv, lib, fetchFromGitHub, cmake, pkg-config, libusb1, libftdi1 }:

stdenv.mkDerivation rec {
  pname = "fujprog";
  version = "4.8";

  src = fetchFromGitHub {
    owner = "kost";
    repo = pname;
    rev = "v${version}";
    sha256 = "08kzkzd5a1wfd1aycywdynxh3qy6n7z9i8lihkahmb4xac3chmz5";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ libftdi1 libusb1 ];

  meta = with lib; {
    description = "FPGA JTAG programmer for ULX2/3S boards";
    homepage = "https://github.com/kost/fujprog";
    license = licenses.bsd2;
    platforms = platforms.linux;
    maintainers = with maintainers; [ artemist ];
  };
}
