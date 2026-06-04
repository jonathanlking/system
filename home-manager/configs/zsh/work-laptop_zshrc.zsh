home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#work-laptop"
}

# Include more statistics with `time`
if [[ `uname` == Darwin ]]; then
  MAX_MEMORY_UNITS=KB
else
  MAX_MEMORY_UNITS=MB
fi

TIMEFMT=$(cat <<-END
  %J   %U  user %S system %P cpu %*E total
  avg shared (code):         %X KB
  avg unshared (data/stack): %D KB
  total (sum):               %K KB
  max memory:                %M $MAX_MEMORY_UNITS
  page faults from disk:     %F
  other page faults:         %R
END
)

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
