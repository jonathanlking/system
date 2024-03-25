# Load bash completion in Zsh
autoload -Uz bashcompinit
bashcompinit

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

notify () {
  local message=`cat /dev/stdin`
  # TODO: Try to get working with env instead of source
  # env $(cat ~/.secrets/pushover.env | xargs)
  source ~/.secrets/pushover.env
  curl -s \
    --form-string "token=$PUSHOVER_TOKEN" \
    --form-string "user=$PUSHOVER_USER" \
    --form-string "message=$message" \
    https://api.pushover.net/1/messages.json
  unset PUSHOVER_TOKEN
  unset PUSHOVER_USER
}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
