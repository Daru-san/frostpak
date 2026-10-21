{
  lib,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pkg-config,
  openssl,
  fontconfig,
  nasm,
  libx11,
  libxcursor,
  libxrandr,
  libxi,
  libGL,
  libxkbcommon,
  wayland,
  stdenv,
  gtk3,
  perl,
  shaderc,
  wrapGAppsHook3,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "oculante-unstable";

  version = "1.0.0-rc.1";

  src = fetchFromGitHub {
    owner = "woelper";
    repo = "oculante";
    tag = finalAttrs.version;
    hash = "sha256-U1burm5/rVSpx7V8YKWC9bQw9P728pjGKoWGpB5+Iy8=";
  };

  cargoHash = "sha256-cudIZB+hyCDJLURX9IrdUZYd6XMMklj/KrPwtyf2YxM=";

  env.SHADERC_LIB_DIR = "${lib.getLib shaderc}/lib";

  nativeBuildInputs = [
    cmake
    pkg-config
    nasm
    perl
    wrapGAppsHook3
  ];

  buildInputs = [
    openssl
    fontconfig
    shaderc
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    libGL
    libx11
    libxcursor
    libxi
    libxrandr
    gtk3
    libxkbcommon
    wayland
  ];

  checkFlags = [
    "--skip=bench"
    "--skip=tests::net" # requires network access
    "--skip=tests::flathub"
    "--skip=thumbnails::test_thumbs" # broken as of v0.9.2
  ];

  # The below patch is needed to fix this build, until the upstream dependency (libavif-rs) fixes the problem.
  # <https://github.com/njaard/libavif-rs/issues/122>
  postPatch = ''
    patch -p1 -d "$cargoDepsCopy"/*/libaom-sys-0.17.2+libaom.3.11.0 -i ${./libaom-sys-0.17.2+libaom.3.11.0-cmake-nasm-fix.patch}
  '';

  postInstall = ''
    install -Dm444 $src/res/icons/icon.png $out/share/icons/hicolor/128x128/apps/oculante.png
    install -Dm444 $src/res/oculante.desktop -t $out/share/applications
    wrapProgram $out/bin/oculante \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath (
          [
            libGL
            libxkbcommon
          ]
          ++ lib.optionals stdenv.hostPlatform.isLinux [ wayland ]
        )
      }
  '';

  passthru.updateArgs = [ "--version=unstable" ];

  meta = {
    broken = stdenv.hostPlatform.isDarwin;
    description = "Minimalistic crossplatform image viewer written in Rust";
    homepage = "https://github.com/woelper/oculante";
    changelog = "https://github.com/woelper/oculante/blob/${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    mainProgram = "oculante";
    maintainers = [
    ];
  };
})
