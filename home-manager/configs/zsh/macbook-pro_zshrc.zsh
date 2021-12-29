typeset -U path
path=(
      $HOME/.nix-profile/bin
      /run/current-system/sw/bin
      $HOME/.local/cargo/bin
      $HOME/.config/emacs/bin
      $HOME/.npm-packages/bin
      $HOME/.poetry/bin
      $HOME/.local/flutter/bin
      /Applications/Tailscale.app/Contents/MacOS
      $HOME/.local/zig
      $HOME/go/bin
      $HOME/.ghcup/bin
      /Applications/Julia-1.5.app/Contents/Resources/julia/bin
      $HOME/.gem/ruby/2.6.0/bin/
      /Users/michael/n/bin
      /Library/TeX/Root/bin/x86_64-darwin/
      /Users/michael/.npm-packages/bin
      /usr/local/bin
      /usr/local/sbin
      /usr/bin
      /bin
      /sbin
      $path
    )

export TERMINFO=$HOME/.config/terminfo
export CLICOLOR=1

home-upgrade () {
  nix flake update $HOME/system/home-manager
}

home-switch () {
  home-manager switch --flake "$HOME/system/home-manager#macbook-pro"
}
