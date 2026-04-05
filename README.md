# frostpak

A repository of nix packages not available in upstream nixpkgs.

Available packages are listed in [PACKAGES.md](PACKAGES.md).


## Why frostpak?

The name is derived from flatpak, where flat is replaced with frost (for nix).

## Usage

This repository provides a nix flake that exports the package definitions.
Do not override the nixpkgs input, I cannot guarantee that the package builds
will work. It may also force rebuilds.

```nix
# flake.nix
{
  inputs = {
    # Do not
    frostpak.url = "github:Daru-san/frostpak";
    #
    frostpak.inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

```nix
# home.nix
{pkgs, ...}: {
  # Use the flake input
  home.packages = [ inputs.snowpkgs.packages.${pkgs.hostPlatform.system}.vigil ];

  # Or the overlay
  home.packages = [ pkgs.vigil ];
}
```

### Caching

Builds are done by [garnix ci](https://garnix.io/docs/ci/) and are thus pushed to the
garnix binary cache.

```nix
# Adding the binary cache
# Rebuild the system before using any of the provided packages to avoid manually building
# the packages.
nix.settings = {
  substituters = [
     "https://cache.garnix.io"
  ];
  trusted-public-keys = [
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
}
```


## Todos

- Update the build script to run in CI without intervention
- Update documentation
- Auto generate package list with versions in a PACKAGES.md file
