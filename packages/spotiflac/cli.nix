{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "spotiflac-cli";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "Nizarberyan";
    repo = "SpotiFLAC";
    tag = "v${finalAttrs.version}";
    hash = "sha256-pjDD7FZbuok4ccBN7sGWb0KzMFi4ZfsEcYmM1pWYyGU=";
  };

  vendorHash = "sha256-Gdh1aE3OBAMXlN/eVCABC0MEHta6eXWgAjYEm9K+mU8=";

  ldflags = [ "-s" ];

  tags = [ "headless" ];

  meta = {
    description = "Get Spotify tracks in true FLAC from Tidal, Qobuz & Amazon Music — no account required";
    homepage = "https://github.com/Nizarberyan/SpotiFLAC";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "spoti-lac";
  };
})
