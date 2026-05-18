{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  hyprlandPlugins,
}:

hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hymission";
  version = "0.3.3-0.55.0";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-j85Nx5LMHZhRyKAODusmab1Ll2pKjM/IaImybocwzAE=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = {
    description = "Mission control style workspace&windows overview plugin for Hyprland";
    homepage = "https://github.com/gfhdhytghd/hymission";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ daru-san ];
    mainProgram = "hymission";
    platforms = lib.platforms.all;
  };
})
