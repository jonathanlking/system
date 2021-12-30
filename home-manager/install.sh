#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 <MACHINE-NAME>

Configure a machine according to its home-manager description.

Arguments:

<MACHINE-NAME>
  The name of the machine, e.g. "macbook-pro".
  These correspond to the attributes under homeConfigurations in the home-manager/flake.nix
EOF
  exit 1
}

main() {
  [[ $# -gt 0 ]] || usage
  local -r machine_name="$1"; shift

  echo "Initialising $machine_name"
  nix build --experimental-features "nix-command flakes" ".#$machine_name"
  ./result/activate
}

main "$@"
