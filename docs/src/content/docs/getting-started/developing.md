---
title: Developing
description: How to develop NixDots
sidebar:
    order: 4
---
Now that you've got NixDots set up and ready to roll, it's time to start learning how to develop it
so you can change things to your liking or even better, if you desire to contribute to this project.

The flake sets a formatter and creates a default devshell that you can use to create a nice and
simple development environment very easily. Just run `nix develop` to enter the development shell.

## The Devshell
The devshell described in the flake installs a bunch of packages that will come in handy for working
on NixDots.
- [NixNvim](https://github.com/Voxi0/NixNvim) - My custom Neovim configuration for NixOS using nixCats.
    I'm highly biased towards Neovim and absolutely adore it. It's a pretty decent config for
    working on this project cozily.
- [Git](https://git-scm.com/) - The world's most popular version control system. This needs no
    introduction. You absolutely need this because then you can easily revert code whenever among other
    things.
- [Deadnix](https://github.com/astro/deadnix) - Scans Nix files for dead/unused code. Just run the
    `deadnix` command in the base directory of NixDots.
- [Statix](https://github.com/oppiliappan/statix) - Provides linting and suggestions for Nix. This
    ensures that good Nix practices are being followed throughout the codebase.

## Formatting
As you can see in the flake, we're using the [Alejandra](https://github.com/kamadorueda/alejandra)
formatter for this project. Just run `nix fmt .` in the base directory of NixDots to format all
the Nix files.

It should finish formatting in little to no time at all. Now you can write Nix code the way you like
and then easily format it to a very popular and general code format with this simple command. Please
format your code so all Nix files can maintain the same code style to ensure readability and such.
