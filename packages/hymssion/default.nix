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
  version = "0.12.0-v0.57.0";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-0RBerr/bvQgdlAOg+1OwdnpPkdBqHbrzgv0R/8UF6jY=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    nlohmann_json
  ];

  passthru.updateArgs = [ ];

  meta = {
    description = "Mission control style workspace&windows overview plugin for Hyprland";
    homepage = "https://github.com/gfhdhytghd/hymission";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = hyprland.meta.platforms;
  };
})
