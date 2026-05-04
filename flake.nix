{
  description = "The packages I use that have not been upstreamed to nixpkgs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      self,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        imports = [ flake-parts.flakeModules.easyOverlay ];
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
        perSystem =
          {
            config,
            pkgs,
            ...
          }:
          {
            overlayAttrs = config.packages;
            devShells.default = pkgs.mkShellNoCC {
              packages = [ config.packages.snow-updater ];
            };
            packages = rec {
              bridge-editor = pkgs.callPackage ./packages/bridge { };
              xbyak-aarch64 = pkgs.callPackage ./packages/xbyak-aarch64 { };
              tanuki3ds = pkgs.callPackage ./packages/tanuki3ds { inherit xbyak-aarch64; };
              vigil = pkgs.callPackage ./packages/vigil { };
              spotiflac = pkgs.callPackage ./packages/spotiflac { };
              spotiflac-cli = pkgs.callPackage ./packages/spotiflac/cli.nix { };
              hymission = pkgs.callPackage ./packages/hymssion { };
              snow-updater = pkgs.callPackage ./scripts/default.nix { };
              index-fm = pkgs.callPackage ./packages/index-fm { };
            };
            formatter = pkgs.nixfmt-rfc-style;
          };
      }
    );
}
