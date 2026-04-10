{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "spotiflac";
  version = "7.1.3";

  src = fetchFromGitHub {
    owner = "afkarxyz";
    repo = "SpotiFLAC";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WvU5Q5qcamtxASJ0ri2TdIPTiMgHlO0bmyqZfrgrV9o=";
  };

  vendorHash = "sha256-CEnh8YNxCY4Z33DJW9fPGLg+AHGBoyf1ECzdgi7c5eA=";

  ldflags = [ "-s" ];

  meta = {
    description = "Get Spotify tracks in true FLAC from Tidal, Qobuz & Amazon Music — no account required";
    homepage = "https://github.com/afkarxyz/SpotiFLAC";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "spotiflac";
  };
})
