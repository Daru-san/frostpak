{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  xz,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "tuidict";
  version = "0.2.1";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "404Simon";
    repo = "tuidict";
    tag = finalAttrs.version;
    hash = "sha256-WOyBCVHQlAXXC4ItSe6c9SRTof4H8sYhFOGueQd7kgg=";
  };

  cargoHash = "sha256-SoQPKkCpMoGFgpAQkQZqRXCXvvwpD468wEgipxnM7y4=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    xz
  ];

  passthru.updateArgs = [ ];

  meta = {
    description = "TUI dictionary with support for multiple language pairs from FreeDict";
    homepage = "https://github.com/404Simon/tuidict";
    changelog = "https://github.com/404Simon/tuidict/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "tuidict";
  };
})
