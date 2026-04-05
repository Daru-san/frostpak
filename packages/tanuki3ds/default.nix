{
  lib,
  fetchFromGitHub,
  llvmPackages_19,
  sdl3,
  xxHash,
  cglm,
  fdk_aac,
  capstone,
  xbyak,
  xbyak-aarch64,
  pkg-config,
  glew,
  libGL,
}:
let
  stdenv = llvmPackages_19.stdenv;
in

stdenv.mkDerivation rec {
  pname = "tanuki3-ds";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "burhanr13";
    repo = "Tanuki3DS";
    rev = "v${version}";
    hash = "sha256-+Y33OmP4Cq7MeP33fCHdYOKN7aKq5LFrhv0VZXeh2wg=";
  };

  CPATH = lib.makeSearchPathOutput "dev" "include" [ stdenv.cc.libc ];

  nativeBuildInputs = [
    llvmPackages_19.clang
    pkg-config
  ];

  buildInputs = [
    sdl3
    cglm
    xxHash
    fdk_aac
    capstone
    glew
    libGL
  ]
  ++ lib.optional stdenv.hostPlatform.isx86_64 [ xbyak ]
  ++ lib.optional stdenv.hostPlatform.isAarch64 [ xbyak-aarch64 ];

  makeFlags = [
    "CC=clang"
  ];

  meta = {
    description = "3DS Emulator";
    homepage = "https://github.com/burhanr13/Tanuki3DS";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "tanuki3-ds";
    platforms = lib.platforms.all;
  };
}
