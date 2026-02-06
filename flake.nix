{
  description = "nix-darwin system flake";

  inputs = {
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs = {
        brew-api.follows = "brew-api";
        nix-darwin.follows = "nix-darwin";
        nixpkgs.follows = "nixpkgs";
      };
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      flake-parts,
      home-manager,
      nix-darwin,
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
          let
            pnpm = pkgs.runCommand "pnpm" { buildInputs = [ pkgs.corepack ]; } ''
              mkdir -p $out/bin
              corepack enable pnpm --install-directory=$out/bin
            '';
          in
          {
            _module.args.pkgs = import inputs.nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.brew-nix.overlays.default
                (_final: prev: {
                  vscode =
                    let
                      version = "1.109.0";
                    in
                    if system == "aarch64-darwin" then
                      prev.vscode.overrideAttrs {
                        src = builtins.fetchurl {
                          name = "VSCode_${version}_darwin-arm64.zip";
                          url = "https://update.code.visualstudio.com/${version}/darwin-arm64/stable";
                          sha256 = "09xjwwgqsz1yv4k83dkvsh3a3cc9xv0011nm3nvma9nnyc681xk9";
                        };
                        inherit version;
                      }
                    else
                      prev.vscode;
                })
              ];
            };
            devShells.default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                # Command
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
          darwinConfigurations."ponko2" = withSystem "aarch64-darwin" (
            { pkgs, ... }:
            nix-darwin.lib.darwinSystem {
              inherit pkgs;
              modules = [
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
