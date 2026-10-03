{
  makeWrapper,
  nix-update,
  lib,
  python3Packages,
  nixfmt,
  freezedocs,
}:
python3Packages.buildPythonApplication rec {
  pname = "freezeup";
  version = "1.2";
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
        freezedocs
      ];
    in
    ''
      wrapProgram $out/bin/freezeup \
        --prefix PATH : ${wrapperPath}
    '';

  meta = {
    description = "The update script for my frostpak";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "freezeup";
  };
}
