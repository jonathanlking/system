home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#linux-desktop"
}

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Use keychain to manage ssh keys
eval $(keychain -q --agents ssh --eval)

zle -N edit-command-line
bindkey "^v" edit-command-line

git-sed () {
  local pattern="$1"; shift
  local replacement="$1"; shift
  git grep -z --files-with-matches -i "$pattern" | xargs -0 sed -i -e "s/$pattern/$replacement/g"
}
