{ stdenv, lib, kernel }:

stdenv.mkDerivation rec {
  pname = "dptx-dummy";
  version = "0.1";
  src = ./src;
  nativeBuildInputs = kernel.moduleBuildDependencies;
  setSourceRoot = ''
    export sourceRoot=$(pwd)/src;
  '';
  makeFlags = [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
  ];
  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];
  meta = with lib; {
    description = "Dummy module that requires rockchip/dptx.bin";
    homepage = "https://artem.ist";
    license = licenses.gpl2;
    maintainers = [ maintainers.artemist ];
    platforms = platforms.linux;
  };
}
