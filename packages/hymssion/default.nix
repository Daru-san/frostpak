{
  lib,
  fetchFromGitHub,
  cmake,
  hyprlandPlugins,
  hyprland,
  nlohmann_json,
}:

hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hymission";
  version = "0.6.0-v0.56.2";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-qTMDMM2yIUXC+ciFiDs6RZQVpqTSjEU6J0tYMZBf5xE=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    nlohmann_json
  ];

  meta = {
    description = "Mission control style workspace&windows overview plugin for Hyprland";
    homepage = "https://github.com/gfhdhytghd/hymission";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = hyprland.meta.platforms;
  };
})
