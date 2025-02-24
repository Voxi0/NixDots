# Installation
- Prepare a NixOS installation media and boot into it.
- Open the terminal and run the following commands. Read thoroughly before running each command.
```bash
# Fetch NixDots and `cd` into it
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# List all mounted disks to choose a disk to install NixOS on
lsblk

# Declaratively partition and format disks - Make sure to replace `<install disk>` with the path to the actual disk to install NixOS on e.g. `/dev/sda`
# Will automatically mount the install disk afterwards in `/mnt/`
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko --argstr device <install disk> ./disko.nix

# Set your username (Set to my personal username by default `voxi0`) and the disk where NixOS is installed (REQUIRED)
nano ./flake.nix    # Nano is installed by default, use another editor if you want

# Generate a new `hardware-configuration.nix` for the new system
sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hardware-configuration.nix

# Move NixDots to the new system - `/etc/nixos` by default but you can move it wherever you want after installing
sudo mkdir -p /mnt/etc/nixos
sudo cp -r ./* /mnt/etc/nixos/

# Install NixOS - Replace `<hostname>` with the actual host to install e.g. `neo`
sudo nixos-install --no-channel-copy --flake /mnt/etc/nixos/<hostname>

# Chroot into the new system to run additional commands like changing your password
sudo nixos-enter
passwd root             # Change the root password from `nixos` to something else if you want
passwd <your_username>  # Definitely change your password from `nixos` to something else

# Installation is complete! Power off and remove the installation media
poweroff
```
