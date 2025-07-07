---
title: Installation
description: How to install NixDots
sidebar:
    order: 2
---
### Fresh Install
- Download [NixOS](https://nixos.org/download/) and flash it to the installation media e.g. a USB drive.
I recommend using [Ventoy](https://www.ventoy.net/en/index.html) for making a bootable USB drive.
- Boot into the installation media and open the browser to this site to run the commands below after opening the terminal.
- Run the following commands after carefully reading the instructions given before each of them.
```bash
# Fetch NixDots and `cd` into it
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# Configure some stuff like username, timezone, keyboard layout etc.
# Nano is installed by default, use another editor if you want
nano ./flake.nix

# List all mounted disks to choose a disk to install NixOS on
# Replace `<disk label/name>` with the name of the disk you wish to install NixOS on e.g. `/dev/sda`
lsblk
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --argstr device "<disk label/name>" ./disko.nix

# !!IMPORTANT!!
# Remove the existing `hardware-configuration.nix` file from the host you wish to use in `hosts/<host you wanna use>`
# Now generate a new `hardware-configuration.nix` to replace it
# Skipping this step will cause data loss among other not very nice things
sudo nixos-generate-config --show-hardware-config --root /mnt > hardware-configuration.nix

# Copy NixDots to the new system
# Can be wherever you want, here we move it to just `/home` where all user home folders live
mkdir -p /home/NixDots
cp -r ./* /home/NixDots/

# Install NixOS - Replace `<hostname>` with the name of the host to install
sudo nixos-install \
  --flake /mnt/etc/nixos/#<hostname> \
  --option extra-binary-caches https://hyprland.cachix.org \
  --option extra-trusted-public-keys hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=

# Chroot into the new system to run additional commands like changing your password
# Default password for any user is `nixos`
sudo nixos-enter
passwd <your_username>

# Installation is complete! Power off and remove the installation media
poweroff
```

### On An Existing NixOS Installation
```bash
# Fetch NixDots and `cd` into it
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# Configure some stuff like username, timezone, keyboard layout etc.
# Nano is installed by default, use another editor if you want
nano ./flake.nix

# !!IMPORTANT!!
# Remove the existing `hardware-configuration.nix` file from the host you wish to use in `hosts/<host you wanna use>`
# Now generate a new `hardware-configuration.nix` to replace it
# Skipping this step will cause data loss among other not very nice things
nixos-generate-config --show-hardware-config > hardware-configuration.nix

# Rebuild the system - Update the flake if you desire but it may or may not break stuff
# sudo nix flake update
sudo nixos-rebuild boot \
    --flake ./#<hostname> \
    --option extra-binary-caches https://hyprland.cachix.org \
    --option extra-trusted-public-keys hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=

# Reboot your system
reboot
```
