{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.ghc
    zlib
    nix-diff
    cabal-install
    lua-language-server
    typescript-language-server
    # haskellPackages.haskell-language-server
    shellcheck
  ];
}
