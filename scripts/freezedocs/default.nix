{
  makeWrapper,
  nix-update,
  lib,
  python3Packages,
  nixfmt,
}:
python3Packages.buildPythonApplication rec {
  pname = "freezedocs";
  version = "1.1";
  format = "other";

  src = ./.;

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -Dm775 $src/script.py $out/bin/${pname}

    runHook postInstall
  '';

  postInstall =
    let
      wrapperPath = lib.makeBinPath [
        nix-update
        nixfmt
      ];
    in
    ''
      wrapProgram $out/bin/freezedocs \
        --prefix PATH : ${wrapperPath}
    '';

  meta = {
    description = "The docgen script for frostpak";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "freezedocs";
  };
}
