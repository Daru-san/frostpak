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
  version = "0.4.3-v0.56.0";

  src = fetchFromGitHub {
    owner = "gfhdhytghd";
    repo = "hymission";
    tag = "v${finalAttrs.version}";
    hash = "sha256-1VHaqcbdPOSod8Qm2lBFwLCX9Nf8zhTOQFs860BC0Xc=";
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
