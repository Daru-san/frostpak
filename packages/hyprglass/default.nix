{
  lib,
  fetchFromGitHub,
  hyprlandPlugins,
  hyprland,
  wayland-scanner,
}:

hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hyprglass";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "hyprnux";
    repo = "hyprglass";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Jq47p3kJ3N/qw8E83lIewjg9hp7oJw9iIYzMT+YPXic=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib

    cp hyprglass.so $out/lib/libhyprglass.so

    runHook postInstall
  '';

  nativeBuildInputs = [
    wayland-scanner
  ];

  passthru.updateArgs = [ ];

  meta = {
    description = "Hyprland plugin that add blur, lens, difraction, refraction effects to transparent windows. Inspired by Liquid Glass design";
    homepage = "https://github.com/hyprnux/hyprglass";
    changelog = "https://github.com/hyprnux/hyprglass/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = hyprland.meta.platforms;
  };
})
