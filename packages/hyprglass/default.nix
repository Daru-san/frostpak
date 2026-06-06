{
  lib,
  fetchFromGitHub,
  nix-update-script,
  hyprlandPlugins,
  hyprland,
}:

hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hyprglass";
  version = "0.6.2";

  src = fetchFromGitHub {
    owner = "hyprnux";
    repo = "hyprglass";
    tag = "v${finalAttrs.version}";
    hash = "sha256-6qa0PoeKfGSpXpILgp2yuYfRmrQKjDSQWpy8q27u1uE=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib

    cp hyprglass.so $out/lib/libhyprglass.so

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Hyprland plugin that add blur, lens, difraction, refraction effects to transparent windows. Inspired by Liquid Glass design";
    homepage = "https://github.com/hyprnux/hyprglass";
    changelog = "https://github.com/hyprnux/hyprglass/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = hyprland.meta.platforms;
  };
})
