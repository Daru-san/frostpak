{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "jotoba-tui";
  version = "1.1.0";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "kurojs";
    repo = "jotoba-tui";
    tag = "v${finalAttrs.version}";
    hash = "sha256-678kPrQVeBqCIexqU7Q07xYh+f4OJhFbEyn1SbDiGbY=";
  };

  vendorHash = "sha256-HsV9tFxW9vLAFHgVFrBopSqgdN/wAN1ss734rPQMbNM=";

  ldflags = [ "-s" ];

  passthru.updateArgs = [ ];

  meta = {
    description = "Japanese dictionary TUI — word, kanji, and sentence search powered by the Jotoba API";
    homepage = "https://github.com/kurojs/jotoba-tui";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "jotoba-tui";
  };
})
