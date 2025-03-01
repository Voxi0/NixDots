# Post-Installation
- **Update the system**: The Nix Helper CLI is installed so you might wanna use that instead of `nixos-rebuild` as it just looks nicer and is more informative. It's a really nice tool in general. `cd` into NixDots and run `nh os boot -H <hostname> ./flake.nix --update` to update the system and add it to the boot menu, then reboot your system to select the latest generation. Look into `nh os clean` to clean up garbage. I'm sure you can figure out how to use `nh` yourself.

- **Move NixDots somewhere else**: Don't keep NixDots `/etc/nixos`, move it somewhere in your home directory so you can modify it freely. Just moving NixDots isn't enough so run this command to change the ownership of NixDots so you can modify it without superuser, `sudo chown -R <your_username> <nixdots_new_location>`.

- **Gaming**: Run `protonup` to install the latest version of Proton GE which can then be selected in Steam, allowing you to play just about every game on Steam on NixOS, or Linux in general. Without Proton, you will be unable to run most Steam games unless they're natively supported which is a select few.
