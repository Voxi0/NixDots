# Installation
## Fresh Install
- Prepare a NixOS installation media and boot into it.
- Open the terminal and run the following commands. Read thoroughly before running each command.
```bash
# Fetch NixDots and `cd` into it
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# Set your username (Set to my personal username by default `voxi0`) and the disk where NixOS is installed (REQUIRED)
nano ./flake.nix    # Nano is installed by default, use another editor if you want

# List all mounted disks to choose a disk to install NixOS on
lsblk

# Run the install script
# Replace `<install_disk>` with the name of the disk to install NixOS to e.g. `/dev/sda`
# Replace `<hostname>` with the NixDots host to install/build e.g. `neo`
./install.sh <install_disk> <hostname>

# Chroot into the new system to run additional commands like changing your password
sudo nixos-enter
passwd root             # Change the root password from `nixos` to something else if you want
passwd <your_username>  # Definitely change your password from `nixos` to something else

# Installation is complete! Power off and remove the installation media
poweroff
```

## On Existing NixOS Installation
```bash
# Fetch NixDots and `cd` into it
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# Set your username and configure other stuff in `flake.nix`
# Nano is installed by default but you can whatever editor you desire
nano ./flake.nix

# !!IMPORTANT!!
# Move your `hardware-configuration.nix` to the NixDots directory
# Or generate a new `hardware-configuration.nix` file with the following command
nixos-generate-config --show-hardware-config > hardware-configuration.nix

# Rebuild the system - Update the flake if you desire but it might break stuff
# sudo nix flake update
sudo nixos-rebuild boot --flake ./#<hostname>

# Reboot your system
reboot
```
