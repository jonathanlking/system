{ config, pkgs, ... }:

let
  imports = [
    ./home/neovim.nix
  ];

in {
  inherit imports;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidgetCommand = "fd --type f";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history.extended = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" ];
      theme = "robbyrussell";
    };
    initExtra = ''
      ${builtins.readFile ./home/config.zsh}
    '';
    sessionVariables = rec {
      EDITOR = "vim";
    };
  };

  home.packages = with pkgs; [
    bat # cat replacement written in Rust
    cachix # Nix build cache
    fd # find replacement written in Rust
    jq # JSON parsing for the CLI
    ripgrep # grep replacement written in Rust
  ];
}
