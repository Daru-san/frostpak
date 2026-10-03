{
  python3,
  fetchFromGitHub,
  lib,
  lzip,
  stdenvNoCC,
}:
let
  wrappedPath = lib.makeBinPath [
    lzip
    python3
  ];
in
stdenvNoCC.mkDerivation rec {
  name = "waydroid_script";

  version = "0-unstable-2026-09-11";

  src = fetchFromGitHub {
    owner = "casualsnek";
    repo = "waydroid_script";
    rev = "48dbfaf34a6ddbe78688c530f9ba1c26522aafb2";
    hash = "sha256-UBbnYhiRCf4sMwpEDMlpJuTEsN66B2hZ8BPz6cCGXAc=";
  };

  buildInputs = [
    (python3.withPackages (
      ps: with ps; [
        tqdm
        requests
        inquirerpy
      ]
    ))
  ];

  postPatch = ''
    patchShebangs main.py
  '';

  installPhase = ''
    mkdir -p $out/libexec
    cp -r . $out/libexec/waydroid_script
    mkdir -p $out/bin
    ln -s $out/libexec/waydroid_script/main.py $out/bin/waydroid_script
  '';

  postInstall = ''
    wrapProgram $out/bin/waydroid_script \
      --prefix PATH : "${wrappedPath}"
  '';

  passthru.updateArgs = [ "--version=branch" ];

  meta.mainProgram = "waydroid_script";
}
