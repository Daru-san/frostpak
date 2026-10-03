# frostpak

> flatpak + nix = frostpak

A repository of nix packages not available in upstream nixpkgs.

Find the full package list in [PACKAGES.md](PACKAGES.md).

Packages are updated regularly by the `freezeup` script via GitHub CI.

## Usage

This repository provides a nix flake that exports the package definitions.

```nix
# flake.nix
{
  inputs = {
    frostpak.url = "github:Daru-san/frostpak";
    # Add this if you want to use a custom version of nixpkgs
    # Note that some builds may fail due to version incompatibilities
    frostpak.inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

```nix
# home.nix
{pkgs, inputs, ...}: {
  # Use the flake input
  home.packages = [ inputs.frostpak.packages.${pkgs.hostPlatform.system}.vigil ];

  # Or using the overlay
  nixpkgs.overlays = [
    inputs.frostpak.overlays.default
  ];

  home.packages = [ pkgs.vigil ];
}
```

### Caching

Due to the recent shutdown of the public garnix service, this repository no longer
provides a binary cache. For the time being, all builds will be run locally without
caching.
