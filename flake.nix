{
  description = "The packages I use that have not been upstreamed to nixpks";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    fabric.url = "github:Fabric-Development/fabric";
  };

  outputs =
    inputs@{
      flake-parts,
      fabric,
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
        flake = {
          homeManagerModules.default =
            { pkgs, ... }:
            {
              imports = [ ./modules/elia.nix ];
              programs.elia.package = withSystem pkgs.stdenv.hostPlatform.system (
                { config, ... }: config.packages.elia
              );
            };
        };
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
              bridge-editor = pkgs.callPackage ./packages/bridge-editor { };
              xbyak = pkgs.callPackage ./packages/xbyak/xbyak.nix { };
              xbyak-aarch64 = pkgs.callPackage ./packages/xbyak/xbyak-aarch64.nix { };
              tanuki3ds = pkgs.callPackage ./packages/tanuki3ds { inherit xbyak xbyak-aarch64; };
              snow-updater = pkgs.callPackage ./scripts/default.nix { };
            };
            formatter = pkgs.nixfmt-rfc-style;
          };
      }
    );
}
