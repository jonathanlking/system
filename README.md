# Nix configurations

This repo contains my nix-ified dev environment (through home-manager) and machine configurations.

Make sure nix > 2.4 installed, as it uses flakes.

Some commands (e.g. `home-switch`) rely on this repo being cloned to your home
directory.

Run `home-manager/install.sh` to quickly set up a home-manager environment.

On `linux-desktop` I had to run `nix-env --set-flag priority 0 nix` to fix a
conflict.

This is heavily inspired/copied from:
* https://github.com/mjlbach/nix-dotfiles
* https://github.com/mitchellh/nixos-config
