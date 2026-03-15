{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:
rustPlatform.buildRustPackage rec {
  pname = "poketex";
  version = "1.16.4";

  src = fetchFromGitHub {
    owner = "ckaznable";
    repo = "poketex";
    rev = "v${version}";
    hash = "sha256-Dd3FMhXoXTD0l1LhnuPZsheUxWl5D08UmFMbeO55+JQ=";
  };

  cargoHash = "sha256-zrneOftxDti6lyu0zSRZWXiQCfPYdciZaCdKO0n7yc8=";

  buildInputs = lib.optionals stdenv.isDarwin [ darwin.apple_sdk.frameworks.CoreFoundation ];

  postInstall = ''
    mkdir -p $out/local/share/poketex
    cp -rf $src/colorscripts $out/local/share/poketex
  '';

  meta = with lib; {
    description = "Simple Pokedex based on TUI(Terminal User Interface";
    homepage = "https://github.com/ckaznable/poketex";
    license = licenses.mit;
    maintainers = with maintainers; [ daru-san ];
    mainProgram = "poketex";
  };
}
