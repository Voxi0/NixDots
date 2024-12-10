# NixDots
This is my personal NixOS and Home Manager setup. I'm using [Disko](https://github.com/nix-community/disko) to declaratively partition disks which automates the install process significantly. Feel free to use my config however you desire.
### How to Install
Just boot into the NixOS installation media e.g. live ISO and run this command. This will fetch NixDots and execute the installer script -
``` sh
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git" && cd NixDots && nix-shell ./install.nix
```
### Specs
- **Kernel** - Linux 6.12
- **DE/WM** - Hyprland
- **Bar** - Aylur's GTK Shell V2 (AGS V2)
- **Terminal** - Kitty
- **Editor** - Neovim and VSCode
- **Browser** - Floorp
### Showcase
![Desktop](./assets/desktop.png "Neo Host")