{
  description = "Example home-manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # inputs.nixpkgs.url = "path:/home/michael/Repositories/nix/nixpkgs";
  # inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

  inputs.emacs-overlay = {
    type = "github";
    owner = "mjlbach";
    repo = "emacs-overlay";
    # rev = "d62b49ac651e314080e333a7e1f190877675ee99";
    # url = "path:/Users/michae/Repositories/emacs-overlay";
    ref = "feature/flakes";
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    # url = "path:/Users/michael/Repositories/nix/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.telescope-fzf-native = {
    url = "github:nvim-telescope/telescope-fzf-native.nvim";
    flake = false;
  };

  inputs.LS_COLORS = {
    url = "github:trapd00r/LS_COLORS";
    flake = false;
  };

  outputs = { self, ... }@inputs:
    let
      # nixos-unstable-overlay = final: prev: {
      #   nixos-unstable = import inputs.nixos-unstable {
      #     system = prev.system;
      #     # config.allowUnfree = true;
      #     overlays = [ inputs.emacs-overlay.overlay ];
      #   };
      # };
      overlays = [
        # nixos-unstable-overlay
        (self: super: {
          telescope-fzf-native = super.callPackage ./packages/telescope-fzf-native.nix {src = inputs.telescope-fzf-native;};
        })
        (self: super: {
          opencv4 = super.opencv4.override { enableUnfree = false; enableCuda = false; };
          blender = super.blender.override { cudaSupport = false; };
        })
        (self: super: {
          zsh-powerlevel10k = super.callPackage ./packages/powerlevel10k.nix {};
        })
        (import ./packages/sumneko_mac.nix)
        inputs.emacs-overlay.overlay
        inputs.neovim-nightly-overlay.overlay
        (final: prev: { LS_COLORS = inputs.LS_COLORS; })
      ];
    in
    # legacyPackages attribute for declarative channels (used by compat/default.nix)
    inputs.flake-utils.lib.eachDefaultSystem (system:
    {
      legacyPackages = inputs.nixpkgs.legacyPackages.${system};
    }
    ) //
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/cli.nix
                # ./modules/emacs.nix
                ./modules/home-manager.nix
                ./modules/neovim.nix
                ./modules/git.nix
                ./modules/nix-utilities.nix
              ];
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
            };
          system = "aarch64-darwin";
          homeDirectory = "/Users/jonathan";
          username = "jonathan";
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
    };
}
