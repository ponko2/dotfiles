{
  description = "nix-darwin system flake";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
              editorconfig-checker = {
                type = "app";
                program = "${pkgs.editorconfig-checker}/bin/editorconfig-checker";
              };
              luacheck = {
                type = "app";
                program = "${pkgs.lua51Packages.luacheck}/bin/luacheck";
              };
              oxfmt = {
                type = "app";
                program = "${pkgs.oxfmt}/bin/oxfmt";
              };
              statix = {
                type = "app";
                program = "${pkgs.statix}/bin/statix";
              };
              stylua = {
                type = "app";
                program = "${pkgs.stylua}/bin/stylua";
              };
            };
            devShells.default = pkgs.mkShellNoCC {
              packages = with pkgs; [
                # Command
                lefthook
                # Formatter
                nixfmt
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
            packages = {
              inherit (pkgs)
                direnv
                nix-direnv
                ;
            };
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
                      uid = 501;
                      shell = pkgs.zsh;
                    };
                  in
                  {
                    environment.etc.nix-darwin.source = "${user.home}/.dotfiles";
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.${user.name} = ./home.nix;
                    };
                    nix-homebrew.user = user.name;
                    system.primaryUser = user.name;
                    users = {
                      knownUsers = [ user.name ];
                      users.${user.name} = user;
                    };
                  }
                )
              ];
              specialArgs = {
                inherit inputs;
              };
            }
          );
          templates.default.path = ./.;
        };
      }
    );
}
