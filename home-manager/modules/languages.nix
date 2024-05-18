{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    haskellPackages.ghc
    nix-diff
    cabal-install
    # haskellPackages.haskell-language-server
    shellcheck
    (if pkgs.stdenv.isDarwin then pkgs.sumneko-lua-language-server-mac else pkgs.sumneko-lua-language-server)
  ];
}
