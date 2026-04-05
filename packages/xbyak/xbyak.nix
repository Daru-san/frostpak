{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  meson,
  ninja,
}:

stdenv.mkDerivation rec {
  pname = "xbyak";
  version = "7.35.4";

  src = fetchFromGitHub {
    owner = "herumi";
    repo = "xbyak";
    rev = "v${version}";
    hash = "sha256-UPqqsG7GeWelOO9AKzveLNa1AYcHFBU6eLjOghDuS1s=";
  };

  nativeBuildInputs = [
    cmake
    meson
    ninja
  ];

  meta = {
    description = "A JIT assembler for x86/x64 architectures supporting MMX, SSE (1-4), AVX (1-2, 512), FPU, APX, and AVX10.2";
    homepage = "https://github.com/herumi/xbyak";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "xbyak";
    platforms = lib.platforms.all;
  };
}
