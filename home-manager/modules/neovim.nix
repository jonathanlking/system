# Neovim settings

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    withNodeJs = true;
    withPython3 = true;

    vimAlias = true;
#    extraConfig = builtins.readFile ./config.vim;
    extraConfig = ''
      luafile ~/.config/nvim/config.lua
      luafile ~/.config/nvim/lsp.lua
"      luafile ~/.config/nvim/treesitter.lua
      luafile ~/.config/nvim/telescope.lua
    '';
    plugins = with pkgs.vimPlugins; [
#      coc-nvim
#      coc-fzf
      fzf-vim # file explorer (fuzzer search)
      solarized # color scheme
      nerdtree # file tree explorer
      vim-nix # syntax highlighting for nix
      vim-airline
      vim-airline-themes
      syntastic
      tabular # text alignment
#      supertab # insert mode completions with Tab
      vim-gitgutter # git status in gutter
      vim-fugitive # Gblame
      vim-highlightedyank # highlight what has just been yanked
      neoformat # code formatting (i.e. ormolu)
      purescript-vim # PureScript syntax highlighting
      vim-javascript
      typescript-vim
      vim-jsx-typescript # Typescript TSX formatting
      vim-strip-trailing-whitespace
#      nvim-treesitter
       nvim-lspconfig
       nvim-compe

       # Telescope
       popup-nvim
       plenary-nvim
       telescope-nvim
    ];
  };

  home.file.".config/nvim/config.lua".source = ../configs/neovim/config.lua;
  home.file.".config/nvim/lsp.lua".source = ../configs/neovim/lsp.lua;
  home.file.".config/nvim/telescope.lua".source = ../configs/neovim/telescope.lua;

#  home.file."coc-settings" = {
#    target = ".config/nvim/coc-settings.json";
#    text = ''
#{
#  "languageserver": {
#    "haskell": {
#      "command": "haskell-language-server-wrapper",
#      "formattingProvider": "ormolu",
#      "args": ["--lsp"],
#      "rootPatterns": [ "cabal.project", "BUILD.bazel" ],
#      "filetypes": [ "hs", "lhs", "haskell", "lhaskell" ],
#      "initializationOptions": {
#        "hlintOn": false,
#        "maxNumberOfProblems": 10,
#        "completionSnippetsOn": true
#      }
#    }
#  },
# "coc.preferences.formatOnSaveFiletypes": [
#    "haskell"
#  ]
#}
#'';
#  };
}
