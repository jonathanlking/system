{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    # haskellPackages.ghc
    # haskellPackages.ghcide
    deno
    # texlab
    rust-analyzer
    rnix-lsp
    vale
    shellcheck
    gopls
    stylua
    nodePackages.pyright
    (if pkgs.stdenv.isDarwin then pkgs.sumneko-lua-language-server-mac else pkgs.sumneko-lua-language-server)
  ];
}
