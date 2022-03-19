{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    aspell # spell checker
    bat # cat replacement written in Rust
    cachix # Nix build cache
    curl
    duff # better du
    difftastic
    exa
    fd # find replacement written in Rust
    fx # JSON viewer
    gnupg
    gnused
    gnutls
    jq # JSON parsing for the CLI
    keychain
    lorri # Easy Nix shell
    nix-zsh-completions
    nmap
    pre-commit
    ripgrep # grep replacement written in Rust
    tealdeer
    tmux
    tree
    universal-ctags
    unzip
    watch
    watchman
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "bazel" "edit-command-line" ];
      theme = "robbyrussell";
    };
    initExtra = ''
      # Enable direnv
      emulate zsh -c "$(direnv hook zsh)"

      alias ls=exa
    '';
    sessionVariables = rec {
      EDITOR = "vim";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = false;
    # enableNixDirenvIntegration = true;
  };

  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "Space";
    extraConfig = builtins.readFile ../configs/tmux/tmux.conf;
  };

}
