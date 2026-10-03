#!/usr/bin/env python
"""Update flake packages with nix-update.

Usage:
  snow-updater                    Search for packages with passthru.updateArgs
  snow-updater -f packages.txt    Read packages from a file
  snow-updater vigil valent       Provide package names

File format, one package per line (# comments allowed):
  bridge-editor
  vigil --version=branch
"""
import argparse
import json
import os
import shlex
import subprocess
import sys


def run_out(cmd):
    return subprocess.check_output(cmd, text=True).strip()


def current_system():
    return run_out(["nix", "eval", "--impure", "--raw", "--expr", "builtins.currentSystem"])


def discover(system):
    """Return {pname: [extra args]} for packages exposing passthru.updateArgs."""
    expr = (
        "ps: builtins.listToAttrs (map (n: { name = n; value = ps.${n}.updateArgs; }) "
        "(builtins.filter (n: ps.${n} ? updateArgs) (builtins.attrNames ps)))"
    )
    out = run_out(["nix", "eval", "--json", f".#packages.{system}", "--apply", expr])
    return json.loads(out)


def read_file(path):
    pkgs = {}
    with open(path) as fh:
        for line in fh:
            line = line.split("#", 1)[0].strip()
            if not line:
                continue
            name, *args = shlex.split(line)
            pkgs[name] = args
    return pkgs


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument("-f", "--file", help="text file listing packages")
    parser.add_argument("packages", nargs="*", help="package names to update")
    opts = parser.parse_args()

    os.chdir(run_out(["git", "rev-parse", "--show-toplevel"]))

    if opts.file:
        pkgs = read_file(opts.file)
    else:
        found = discover(current_system())
        pkgs = {p: found.get(p, []) for p in opts.packages} if opts.packages else found

    if not pkgs:
        print("No packages to update.", file=sys.stderr)
        return 0

    failed = []
    for name, args in pkgs.items():
        print(f"==> {name} {' '.join(args)}", flush=True)
        cmd = ["nix-update", "--flake", name, "--commit", "--format", *args]
        if subprocess.run(cmd).returncode != 0:
            failed.append(name)

    if failed:
        print(f"Failed: {', '.join(failed)}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
