{ config, pkgs, libs, ... }:
{
  
  xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/Repositories/nix/nix-dotfiles/home-manager/configs/neovim/init_dev.lua");
}
