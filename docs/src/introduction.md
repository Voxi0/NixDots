# NixDots
This is my personal [NixOS](https://nixos.org/) configuration/dotfiles using [Flakes](https://nixos.wiki/wiki/flakes) and [Home Manager](https://github.com/nix-community/home-manager). I'm also making use of [Disko](https://github.com/nix-community/disko) to declaratively partition and format disks using Nix. Feel free to use my configuration as you wish and star the repo to show support. Any contributions would be greatly appreciated!

## Why NixOS?
Here's a couple of reasons why I considered using NixOS and eventually moved to it from [Arch Linux](https://github.com/NixOS/nixpkgs). There are many more benefits of using NixOS but these are the most common.
- **Does not break / Easy to recover** - Rebuilding NixOS creates a new generation while preserving the previous generation. This allows the user to easily rollback to the previous generation if things go awry by choosing it in the boot menu.

- **Reproducibility**: It's very easy to have identical systems. All you do is fetch someone's NixOS configuration and rebuild your system using it.

- **Huge Package Repository**: [Nixpkgs](https://github.com/NixOS/nixpkgs) has over 100,000 software packages that you can install with the Nix package manager. It's the largest software repository in existence as of now, even larger than the mighty [AUR](https://github.com/NixOS/nixpkgs).

## Info
- **Kernel** - [Linux (Latest)](https://www.kernel.org/)
- **Shell** - [Fish](https://fishshell.com/)
- **Theming** - [Stylix](https://github.com/danth/stylix)
- **Terminal** - [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Editor** - [Neovim](https://github.com/Voxi0/NvimDots) (Using [NixCats](https://nixcats.org/))
- **DE/WM** -
  - [Hyprland](https://hyprland.org/)
  - [Sway](https://swaywm.org/) (Bare minimum, recommended to use Hyprland instead)
- **Widgets** - [Aylur's GTK Shell (AGS)](https://github.com/Aylur/ags) or more specifically, [Astal](https://github.com/Aylur/Astal)
- **Browser** - [Firefox](https://www.mozilla.org/en-US/firefox/)
