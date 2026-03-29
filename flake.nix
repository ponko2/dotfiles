{
  description = "nix-darwin system flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    nikitabobko-tap = {
      url = "github:nikitabobko/homebrew-tap";
      flake = false;
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      flake-parts,
      home-manager,
      nix-darwin,
      nix-homebrew,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, ... }:
      {
        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];
        perSystem =
          { pkgs, system, ... }:
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [ ];
            };
            apps = {
              commitlint = {
                type = "app";
                program = "${pkgs.commitlint}/bin/commitlint";
              };
              deadnix = {
                type = "app";
                program = "${pkgs.deadnix}/bin/deadnix";
              };
              oxfmt = {
                type = "app";
                program = "${pkgs.oxfmt}/bin/oxfmt";
              };
              statix = {
                type = "app";
                program = "${pkgs.statix}/bin/statix";
              };
            };
            devShells.default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                # Command
                lefthook
                # Formatter
                nixfmt-rfc-style
                oxfmt
                shfmt
                stylua
                # Linter
                checkmake
                commitlint
                deadnix
                editorconfig-checker
                lua51Packages.luacheck
                shellcheck
                statix
                yamllint
                # LSP
                nixd
              ];
              shellHook = ''
                lefthook install
              '';
            };
            formatter = pkgs.nixfmt-tree;
          };
        flake = {
          darwinConfigurations."ponko2" = withSystem "aarch64-darwin" (
            { pkgs, ... }:
            nix-darwin.lib.darwinSystem {
              inherit pkgs;
              modules = [
                nix-homebrew.darwinModules.nix-homebrew
                ./configuration.nix
                home-manager.darwinModules.home-manager
                (
                  let
                    user = rec {
                      name = "kano";
                      home = "/Users/${name}";
                    };
                  in
                  {
                    environment.etc.nix-darwin.source = "${user.home}/dotfiles";
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.${user.name} = ./home.nix;
                    };
                    nix-homebrew.user = user.name;
                    system.primaryUser = user.name;
                    users.users.${user.name} = user;
                  }
                )
              ];
              specialArgs = {
                inherit inputs;
              };
            }
          );
          homeConfigurations."vscode" = withSystem "aarch64-linux" (
            { pkgs, ... }:
            home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                ./home.nix
                (
                  { lib, ... }:
                  {
                    home = rec {
                      username = "vscode";
                      homeDirectory = "/home/${username}";
                      file.".config/git".enable = lib.mkForce false;
                    };
                    programs.home-manager.enable = true;
                  }
                )
              ];
            }
          );
          templates.default.path = ./.;
        };
      }
    );
}
