{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    # haskellPackages.ghc
    # haskellPackages.haskell-language-server
    rnix-lsp
    shellcheck
    (if pkgs.stdenv.isDarwin then pkgs.sumneko-lua-language-server-mac else pkgs.sumneko-lua-language-server)
  ];
}
