#!/usr/bin/env python

import subprocess, os, pathlib


gitRootDir = subprocess.check_output(["git", "rev-parse", "--show-toplevel"])
gitRootDir = gitRootDir[:-1]

os.chdir(gitRootDir)


class Updaters:
    def update_version(self, pname):
            subprocess.run(["nix-update", "-F", pname, "--commit", "--format"])

    def update_branch(self, pname):

        subprocess.run(
            [
                "nix-update",
                "-F",
                pname,
                "--commit",
                "--format",
                "--version",
                "branch",
            ]
        )


ud = Updaters()
version_pnames = ["bridge-editor", "tanuki3ds", "xbyak", "xbyak-aarch64"]
branch_pnames = ["vigil"]

for x in version_pnames:
    ud.update_version(x)

for x in branch_pnames:
    ud.update_branch(x)
