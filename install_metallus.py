#!/usr/bin/python

import yaml
import sys
import subprocess

with open("metallus.yml") as f:
    job = sys.argv[1]
    contents = yaml.load(f)
    subprocess.call(["apt-get", "update", "-qq"])
    deps = contents["jobs"][job].get("build_depends", [])
    for package in deps:
        subprocess.call(["apt-get", "install", "-y", package])
