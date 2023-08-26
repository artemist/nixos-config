{ stdenv, lib, rustPlatform, fetchFromGitHub, pkg-config, cmake, openssl
, llvmPackages, weechat }:

rustPlatform.buildRustPackage rec {
  pname = "weechat-matrix-rs";
  version = "20210530";

  src = fetchFromGitHub {
    owner = "poljar";
    repo = pname;
    rev = "a846e76b7abf9b70fbcbf955255f99fde185b9cb";
    sha256 = "1gx5vxc8391i8cr6d8r6gwywypl0zn3d1xjydg6y6228qcxl3vmm";
  };

  cargoSha256 = "0ikarh474dmbbmg6nz24fap6dqgxg0hy2kp3jpknaz8rgdvjsvjb";

  WEECHAT_PLUGIN_FILE = "${weechat}/include/weechat/weechat-plugin.h";
  LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";
  nativeBuildInputs = [ pkg-config cmake llvmPackages.clang ];
  buildInputs = [ openssl ];

  preFixup = ''
    mkdir -p $out/lib/weechat/plugins
    mv $out/lib/libmatrix.so $out/lib/weechat/plugins/matrix.so
  '';

  meta = with lib; {
    description = "Rust rewrite of the python weechat-matrix script.";
    homepage = "https://github.com/poljar/weechat-matrix-rs";
    license = licenses.mit;
    matinainers = [ maintainers.artemist ];
  };
}
