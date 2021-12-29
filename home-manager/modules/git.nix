{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    git
    git-lfs
    gitAndTools.delta
    gitAndTools.gh
    gitAndTools.git-crypt
    pre-commit
  ];
  home.file.".config/git/ignore".text = ''
    tags
    result
  '';

}
