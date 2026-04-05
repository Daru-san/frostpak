{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "xbyak-aarch64";
  version = "1.1.3";

  src = fetchFromGitHub {
    owner = "fujitsu";
    repo = "xbyak_aarch64";
    rev = "v${version}";
    hash = "sha256-ZiVe7f5uo64ldrFVYwG1Z+gqEY+FJ0E3rgqr3EAJcGE=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = {
    description = "";
    homepage = "https://github.com/fujitsu/xbyak_aarch64/";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = lib.platforms.all;
  };
}
