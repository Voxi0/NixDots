---
title: Post Installation
description: Things to do after installing NixDots
sidebar:
    order: 3
---
## Basics
- **Update the system**: [Nix Helper CLI](https://github.com/nix-community/nh) is installed by default.
Update the system with `nh os boot <path to NixDots> -H <hostname> --update`. The `--update` flag updates the flake.
Check out the [Github repo](https://github.com/nix-community/nh) to learn more.

## Gaming
Run `protonup` to install the latest version of Proton GE which can be used in Steam to play just about every game on
there.

Also run `flatpak update` to update [Sober](https://sober.vinegarhq.org/) which is the Roblox client I'm using here. It's
the only thing from [Flathub](https://flathub.org/) since it's only available as a [Flatpak](https://flatpak.org/).
