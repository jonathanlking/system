{
  description = "Home-manager from non-nixos system";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        (import ./packages/sumneko_mac.nix)
      ];

      defaultConfig = {
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
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";
          modules = [
            (defaultConfig //
            {
              home = {
                file.".config/nix/nix.conf".source = ./configs/nix/nix.conf;
                homeDirectory = "/Users/jonathan";
                username = "jonathan";
                stateVersion = "25.05";
              };
              programs.zsh.initExtraFirst = ''
                # Source nix
                if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
                   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
                fi
              '';
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/macbook-pro_zshrc.zsh;
            })
          ];
        };
        linux-desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
          modules = [
            (defaultConfig //
            {
              home = {
                file.".config/nix/nix.conf".source = ./configs/nix/nix.conf;
                homeDirectory = "/home/jonathan";
                username = "jonathan";
                stateVersion = "25.05";
              };
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/linux-desktop_zshrc.zsh;
            })
          ];
        };
        linux-arm-vm = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
          modules = [
            (defaultConfig //
            {
              home = {
                file.".config/nix/nix.conf".source = ./configs/nix/nix.conf;
                homeDirectory = "/home/jonathan";
                username = "jonathan";
                stateVersion = "25.05";
              };
              programs.zsh.initExtra = builtins.readFile ./configs/zsh/linux-arm-vm_zshrc.zsh;
            })
          ];
        };
      };
      macbook-pro = self.homeConfigurations.macbook-pro.activationPackage;
      linux-desktop = self.homeConfigurations.linux-desktop.activationPackage;
      linux-arm-vm = self.homeConfigurations.linux-arm-vm.activationPackage;
    };
}
