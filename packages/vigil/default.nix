{
  lib,
  stdenv,
  fetchFromGitHub,
  zig_0_15,
  callPackage,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "vigil";
  version = "0-unstable-2026-07-11";

  src = fetchFromGitHub {
    owner = "chase-lambert";
    repo = "vigil";
    rev = "e7911d8eb3d70510e81c34d4e35d2ca624c16266";
    hash = "sha256-WfZDAIzR4yfmSsMDqRp14RjoOEJbLeBp1Vw8ZyURc0I=";
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
    zig_0_15
  ];

  meta = {
    description = "A clean, fast build watcher for Zig";
    homepage = "https://github.com/chase-lambert/vigil";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "vigil";
    inherit (zig_0_15.meta) platforms;
  };
})
