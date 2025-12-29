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
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        { pkgs, ... }:
        let
          packageJSON = pkgs.lib.importJSON ./package.json;
          nodejs =
            pkgs."nodejs_${pkgs.lib.versions.major (pkgs.lib.removePrefix "^" packageJSON.devEngines.runtime.version)}";
          pnpm = pkgs.runCommand "pnpm" { buildInputs = [ nodejs ]; } ''
            mkdir -p $out/bin
            corepack enable pnpm --install-directory=$out/bin
          '';
        in
        {
          devShells.default = pkgs.mkShellNoCC {
            packages = with pkgs; [
              # Command
              nodejs
              pnpm
              # Formatter
              nixfmt-rfc-style
              shfmt
              stylua
              # Linter
              checkmake
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
              pnpm install
            '';
          };
          formatter = pkgs.nixfmt-tree;
        };
      flake = {
        darwinConfigurations."ponko2" = nix-darwin.lib.darwinSystem {
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            ./configuration.nix
            home-manager.darwinModules.home-manager
            (
              { user, ... }:
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${user.name} = ./home.nix;
                };
              }
            )
          ];
          specialArgs = {
            inherit inputs;
            user = rec {
              name = "kano";
              home = "/Users/${name}";
            };
          };
        };
      };
    };
}
