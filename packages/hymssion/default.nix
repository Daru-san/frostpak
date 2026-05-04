{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  hyprlandPlugins,
}:

hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hymission";
  version = "0.3.0-0.54.3";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-YZ4zjX4kqPUXbWsyArj9tezAB7URNl5D10/HRzs/iyw=";
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
