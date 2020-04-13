{ pkgs, ... }:

let

  niv = pkgs.callPackage ./tools/niv.nix {};

  packages =
    [
      niv
      pkgs.bat
      pkgs.cachix
      pkgs.direnv
      pkgs.docker-compose
      pkgs.fd
      pkgs.fzf
      pkgs.git
      pkgs.google-chrome
      pkgs.htop
      pkgs.ispell
      pkgs.nixpkgs-fmt
      pkgs.nix-prefetch-git
      pkgs.postman
      pkgs.slack
      pkgs.tmux
      pkgs.tree
      pkgs.vim
      pkgs.wget
      pkgs.xclip
      pkgs.zoom-us
    ];

in

packages
