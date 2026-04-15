{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "index-fm";
  version = "4.0.2";

  src = fetchFromGitHub {
    owner = "KDE";
    repo = "index-fm";
    tag = "v${finalAttrs.version}";
    hash = "sha256-5h/HNdXl3O8QBfhoJl8oTJbOxn0Jv0yOO1rlTVIuWsQ=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = with kdePackages; [
    extra-cmake-modules
    maui-core
    qtdeclarative
    qtsvg
    kdecoration
    qtbase
  ];

  meta = {
    description = "Multi-platform file manager";
    homepage = "https://github.com/KDE/index-fm";
    license = with lib.licenses; [
      bsd2
      cc0
    ];
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "index-fm";
    platforms = lib.platforms.all;
  };
})
