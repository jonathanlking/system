home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#macbook-pro"
}

# Use keychain to manage ssh keys
eval $(keychain -q --agents ssh --eval)
