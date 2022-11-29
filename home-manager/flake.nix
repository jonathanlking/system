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

    flake-utils.url = "github:numtide/flake-utils";

    # We have access to unstable nixpkgs if we want specific unstable packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Other packages
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs-unstable, ... }@inputs:
    let
      overlays = [
        (import ./packages/sumneko_mac.nix)
        (_: prev: { vimPlugins = nixpkgs-unstable.legacyPackages.${prev.system}.vimPlugins; })
        inputs.neovim-nightly-overlay.overlay
      ];

      defaultConfig = {
        home.file.".config/nix/nix.conf".source = ./configs/nix/nix.conf;
        nixpkgs.config = import ./configs/nix/config.nix;
        nixpkgs.overlays = overlays;
        imports = [
          ./modules/cli.nix
          ./modules/fonts.nix
          ./modules/home-manager.nix
          ./modules/neovim.nix
          ./modules/git.nix
          ./modules/languages.nix
          ./modules/nix-utilities.nix
        ];
      };
    in
    # legacyPackages attribute for declarative channels (used by compat/default.nix)
    inputs.flake-utils.lib.eachDefaultSystem
      (system:
        {
          legacyPackages = inputs.nixpkgs.legacyPackages.${system};
        }
      ) //
    {
      homeConfigurations = {
        macbook-pro = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, config, ... }:
            defaultConfig //
            {
              programs.zsh.initExtraFirst = ''
                # Source nix
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
              '';
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
            };
          system = "aarch64-darwin";
          homeDirectory = "/Users/jonathan";
          username = "jonathan";
          stateVersion = "21.11";
        };
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            defaultConfig //
            {
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/linux-desktop_zshrc.zsh;
            };
          system = "x86_64-linux";
          homeDirectory = "/home/jonathan";
          username = "jonathan";
          stateVersion = "21.11";
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
      linux-desktop = self.homeConfigurations.linux-desktop.activationPackage;
    };
}
