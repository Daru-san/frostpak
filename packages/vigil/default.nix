{
  lib,
  stdenv,
  fetchFromGitHub,
  zig,
  callPackage,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "vigil";
  version = "0.15-compat-unstable-2026-07-24";

  src = fetchFromGitHub {
    owner = "chase-lambert";
    repo = "vigil";
    rev = "8a68814cd3ed47d12b97441eec5b16939d354b26";
    hash = "sha256-xZ+wbxkPQF9PXYmhfTy+yw6VYfqzSbZpHrwzv9j2OjI=";
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

  meta = {
    description = "A clean, fast build watcher for Zig";
    homepage = "https://github.com/chase-lambert/vigil";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "vigil";
    inherit (zig.meta) platforms;
  };
})
