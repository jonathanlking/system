home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#linux-desktop"
}

# Use keychain to manage ssh keys
eval $(keychain -q --agents ssh --eval)

zle -N edit-command-line
bindkey "^e" edit-command-line
