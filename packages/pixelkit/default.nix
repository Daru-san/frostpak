{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  libxkbcommon,
  makeWrapper,
  wayland,
  libGL,
  libX11,
  libxcb,
  nix-update-script,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "pixelkit";
  version = "0.4.2";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "Kuucheen";
    repo = "PixelKit";
    tag = "v${finalAttrs.version}";
    hash = "sha256-hskSTn3Rs20CxY8Dj6AZHqesxK12lMAVyWVORkfu2zY=";
  };

  cargoHash = "sha256-u8S1qSQHmWXpo259XyOC0Qclv3fGECOQUTeMXNqtshU=";

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];
  buildInputs = [
    libGL
    libxkbcommon
    wayland
    libX11
    libxcb
  ];

  postInstall = ''
    install -Dm644 packaging/linux/io.github.Kuucheen.PixelKit.desktop $out/share/applications/io.github.Kuucheen.PixelKit.desktop
    install -Dm644 packaging/linux/io.github.Kuucheen.PixelKit.metainfo.xml $out/share/metainfo/io.github.Kuucheen.PixelKit.metainfo.xml
    install -Dm644 packaging/linux/io.github.Kuucheen.PixelKit.svg $out/share/icons/hicolor/scalable/apps/io.github.Kuucheen.PixelKit.svg
    install -Dm644 packaging/linux/io.github.Kuucheen.PixelKit.png $out/share/icons/hicolor/128x128/apps/io.github.Kuucheen.PixelKit.png
    install -Dm644 packaging/linux/512x512/io.github.Kuucheen.PixelKit.png $out/share/icons/hicolor/512x512/apps/io.github.Kuucheen.PixelKit.png
    install -Dm644 packaging/linux/pixelkit.service $out/lib/systemd/user/pixelkit.service
    install -Dm644 docs/pixelkit.1 $out/share/man/man1/pixelkit.1
    install -Dm644 LICENSE $out/share/licenses/pixelkit/LICENSE
    install -Dm644 LICENSES/Apache-2.0.txt $out/share/licenses/pixelkit/Apache-2.0.txt
    install -Dm644 NOTICE $out/share/doc/pixelkit/NOTICE
  '';

  postFixup = ''
    wrapProgram $out/bin/pixelkit \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          libGL
          libxkbcommon
          wayland
          libX11
          libxcb
        ]
      }
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A lightweight native Linux color picker and screen ruler, inspired by Microsoft PowerToys and built in Rust for Wayland and X11";
    homepage = "https://github.com/Kuucheen/PixelKit";
    changelog = "https://github.com/Kuucheen/PixelKit/releases/tag/${finalAttrs.src.tag}";
    license = with lib.licenses; [
      asl20
      mit
    ];
    maintainers = with lib.maintainers; [ daru-san ];
    platforms = lib.platforms.linux;
    mainProgram = "pixelkit";
  };
})
