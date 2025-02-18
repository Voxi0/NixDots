# Getting Started
## Installation
- Prepare a NixOS installation media and boot into it
- Open the terminal and run the following commands. Please read everything rather than copy-pasting every command below into the terminal
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
# Nano is installed by default, use another editor if you want
nano ./flake.nix

# Generate a new `hardware-configuration.nix` for the new system
sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hardware-configuration.nix

# Move NixDots to the new system - `/etc/nixos` by default but you can move it wherever you want after installing
sudo mkdir -p /mnt/etc/nixos
sudo cp -r ./* /mnt/etc/nixos/

# Install NixOS - Replace `<hostname>` with the actual host to install e.g. `neo`
sudo nixos-install --flake /mnt/etc/nixos/<hostname>

# Installation is complete! Power off and remove the installation media
poweroff
```
## Post-Installation
The default password is set to `nixos`, change it with `sudo passwd <your_username>`. Then enter the password as `nixos` because that's the initial/default password remember?

You should also consider moving NixDots somewhere else rather than keeping it in `/etc/nixos` because then you can modify NixDots which you will definitely want. You could however, change the ownership of `/etc/nixos` or allow yourself write permissions but why bother? Just move it man, since we're using flakes it really doesn't matter where you keep NixDots. You can just rebuild the system by passing the flake to your build command or whatever.

I'm using the Nix Helper CLI because it looks really cool and is just nice in general. Just `cd` into NixDots and run `nh os switch -H <hostname> ./flake.nix` to rebuild NixOS and switch to the new generation. You could just pass the flake to your command as well to run this command from anywhere. You can also use `nh os boot` and `nh os test`. I recommend using `nh os test` when you're experimenting as it avoids polluting your system by creating boot entries for the new generations.

You may also want to update your system to have the latest everything as I usually don't make commits for system updates. Just pass the `--update` or `-u` flag to the commands I showed above for rebuilding NixOS to update the flake.
