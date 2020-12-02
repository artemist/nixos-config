{ stdenv, fetchurl, cups, dpkg, gnused, makeWrapper, ghostscript, file, a2ps, coreutils, gawk, perl, gnugrep, which }:
let
  version = "3.2.0-1";
  lprdeb = fetchurl {
    url = "https://download.brother.com/welcome/dlf101900/hll2300dlpr-${version}.i386.deb";
    sha256 = "093ya7qykhk8mnbiwz1wy0qly66mmk0ghd1rgla25biask5nnmwv";
  };

  cupsdeb = fetchurl {
    url = "https://download.brother.com/welcome/dlf101901/hll2300dcupswrapper-${version}.i386.deb";
    sha256 = "1fylsbnxbljh517lbdr3324jsi4fwhbfh6gzrdvifg0wl20vfwqr";
  };

in
stdenv.mkDerivation {
  name = "cups-brother-hll2300dw";

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ cups ghostscript dpkg a2ps ];

  dontUnpack = true;

  installPhase = ''
        mkdir -p $out
        dpkg-deb -x ${cupsdeb} $out
        dpkg-deb -x ${lprdeb} $out

        substituteInPlace $out/opt/brother/Printers/HLL2300D/lpd/filter_HLL2300D \
          --replace /opt "$out/opt" \
          --replace /usr/bin/perl ${perl}/bin/perl \
          --replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$out/opt/brother/Printers/HLL2300D/\"; #" \
          --replace "PRINTER =~" "PRINTER = \"HLL2300D\"; #"

        patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
          $out/opt/brother/Printers/HLL2300D/lpd/brprintconflsr3
        patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
          $out/opt/brother/Printers/HLL2300D/lpd/rawtobr3

        for f in \
          $out/opt/brother/Printers/HLL2300D/cupswrapper/brother_lpdwrapper_HLL2300D \
          $out/opt/brother/Printers/HLL2300D/cupswrapper/paperconfigml1 \
        ; do
          wrapProgram $f \
            --prefix PATH : ${stdenv.lib.makeBinPath [
              coreutils
    ghostscript
    gnugrep
    gnused
            ]}
        done

        mkdir -p $out/lib/cups/filter/
        ln -s $out/opt/brother/Printers/HLL2300D/lpd/filter_HLL2300D $out/lib/cups/filter/brother_lpdwrapper_HLL2300D

        mkdir -p $out/share/cups/model
        ln -s $out/opt/brother/Printers/HLL2300D/cupswrapper/brother-HLL2300D-cups-en.ppd $out/share/cups/model/

        wrapProgram $out/opt/brother/Printers/HLL2300D/lpd/filter_HLL2300D \
          --prefix PATH ":" ${ stdenv.lib.makeBinPath [ ghostscript a2ps file gnused gnugrep coreutils which ] }
  '';

  meta = with stdenv.lib; {
    homepage = "http://www.brother.com/";
    description = "Brother hl-l2300dw printer driver";
    license = licenses.unfree;
    platforms = platforms.linux;
    downloadPage = "https://support.brother.com/g/b/downloadlist.aspx?c=de&lang=de&prod=hll2300d_us_eu_as&os=128&flang=English";
    maintainers = [ maintainers.artemist ];
  };
}
