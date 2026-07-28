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
  version = "0.5.0-v0.56.0";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-1Hn1Op3vKJZZoM4mg0fmCl8zvy8wGp15uINeDDFc/vA=";
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
