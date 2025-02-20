# Getting Started
## Installation
- Prepare a NixOS installation media and boot into it
- Open the terminal and run the following commands. Please read everything rather than copy-pasting every command below into the terminal
```bash
# Fetch NixDots and `cd` into it (REQUIRED)
nix-shell -p git --run "git clone https://github.com/Voxi0/NixDots.git"
cd NixDots

# Set your username (Default - `voxi0`) and the disk where NixOS is installed (Default - `/dev/sda`)
# Nano is installed by default, use another editor if you want
nano ./flake.nix

# List all mounted disks to choose a disk to install NixOS on
lsblk

# Run the install script
# Replace `<install_disk>` with the name of the disk to install NixOS to e.g. `/dev/sda`
# Replace `<hostname>` with the NixDots host to install/build e.g. `neo`
./install.sh <install_disk> <hostname>
```
## Post-Installation
The default password is set to `nixos`, change it with `sudo passwd <your_username>`. Then enter the password as `nixos` because that's the initial/default password remember?

You should also consider moving NixDots somewhere else rather than keeping it in `/etc/nixos` because then you can modify NixDots which you will definitely want. You could however, change the ownership of `/etc/nixos` or allow yourself write permissions but why bother? Just move it man, since we're using flakes it really doesn't matter where you keep NixDots. You can just rebuild the system by passing the flake to your build command or whatever.

I'm using the [Nix Helper CLI](https://github.com/viperML/nh) because it looks really cool and is just nice in general. Just `cd` into NixDots and run `nh os switch -H <hostname> ./flake.nix` to rebuild NixOS and switch to the new generation. You could just pass the flake to your command as well to run this command from anywhere. You can also use `nh os boot` and `nh os test`. I recommend using `nh os test` when you're experimenting as it avoids polluting your system by creating boot entries for the new generations.

You may also want to update your system to have the latest everything as I usually don't make commits for system updates. Just pass the `--update` or `-u` flag to the commands I showed above for rebuilding NixOS to update the flake.

As for gaming, run `protonup` to install Proton GE which you can then select in Steam in order to be able to play more or less every Steam game. Without Proton, you will be unable to play more or less every game out there except for select few.
