. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# Load bash completion in Zsh
autoload -Uz bashcompinit
bashcompinit

home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#linux-arm-vm"
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

# Set history sizes
HISTSIZE=1000000000      # Number of commands kept in memory
SAVEHIST=1000000000      # Number of commands saved to the history file

# Options to make history behave nicely
setopt APPEND_HISTORY     # Append history instead of overwriting
setopt INC_APPEND_HISTORY # Save commands as they are entered
setopt SHARE_HISTORY      # Share history across multiple sessions
setopt HIST_IGNORE_DUPS   # Don't record the same command twice in a row
setopt HIST_IGNORE_ALL_DUPS # Remove older duplicates
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks

source <(fzf --zsh)
