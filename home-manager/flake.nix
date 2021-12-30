{
  description = "Home-manager from non-nixos system";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # We have access to unstable nixpkgs if we want specific unstable packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Other packages
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    LS_COLORS = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        (import ./packages/sumneko_mac.nix)
        inputs.neovim-nightly-overlay.overlay
        (final: prev: { LS_COLORS = inputs.LS_COLORS; })
      ];
    in
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              home.file.".config/nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                ./modules/home-manager.nix
                ./modules/neovim.nix
                ./modules/git.nix
                ./modules/languages.nix
                ./modules/nix-utilities.nix
              ];
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
            };
          system = "aarch64-darwin";
          homeDirectory = "/Users/jonathan";
          username = "jonathan";
          stateVersion = "21.11";
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
    };
}
