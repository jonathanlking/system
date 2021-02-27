# Required for home-manager to run
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

# Hook to direnv
eval "$(direnv hook zsh)"
