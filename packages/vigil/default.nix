{
  lib,
  stdenv,
  fetchFromGitHub,
  zig,
  callPackage,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "vigil";
  version = "0.15-compat-unstable-2026-10-04";

  src = fetchFromGitHub {
    owner = "chase-lambert";
    repo = "vigil";
    rev = "d13a91c95c326fd238d6ab4b0dccc1caf0e7950b";
    hash = "sha256-7qcSJP6Jx0DWNuTdfNRtimS3c7LyT9fqQ9R/T/L4NmI=";
  };

  deps = callPackage ./build.zig.zon.nix { };

  strictDeps = true;

  zigBuildFlags = finalAttrs.zigCheckFlags ++ [
    "-Doptimize=ReleaseSafe"
  ];

  zigCheckFlags = [
    "--system"
    "${finalAttrs.deps}"
    "-Dcpu=baseline"
  ];

  dontSetZigDefaultFlags = true;

  nativeBuildInputs = [
    zig
  ];

  passthru.updateArgs = [ "--version=branch" ];

  meta = {
    description = "A clean, fast build watcher for Zig";
    homepage = "https://github.com/chase-lambert/vigil";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "vigil";
    inherit (zig.meta) platforms;
  };
})
