# Neovim settings

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;
    plugins = with pkgs.vimPlugins; [
      fzf-vim # file explorer (fuzzer search)
      solarized # color scheme
      nerdtree # file tree explorer
      vim-nix # syntax highlighting for nix
      vim-airline
      vim-airline-themes
      syntastic
      tabular # text alignment
      supertab # insert mode completions with Tab
      vim-gitgutter # git status in gutter
      vim-fugitive # Gblame
    ];
  };
}
