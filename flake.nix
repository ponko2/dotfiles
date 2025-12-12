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
    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      self,
      flake-parts,
      home-manager,
      homebrew-cask,
      homebrew-core,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
    }:
    let
      username = "kano";
      hostname = "ponko2";
      homebrewConfiguration = {
        nix-homebrew = {
          enable = true;
          enableRosetta = false;
          user = username;
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
          };
          mutableTaps = false;
        };
      };
      darwinConfiguration =
        { config, pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          # environment.systemPackages = with pkgs; [ ];

          environment.etc.nix-darwin.source = "/Users/${username}/dotfiles";

          fonts.packages = with pkgs; [
            udev-gothic
            udev-gothic-nf
          ];

          homebrew = {
            enable = true;

            casks = [
              "1password"
              "1password-cli"
              "adobe-acrobat-reader"
              "appcleaner"
              "devtoys"
              "docker-desktop"
              "ghostty"
              "google-chrome"
              "iterm2"
              "karabiner-elements"
              "monitorcontrol"
              "rectangle"
              "the-unarchiver"
              "visual-studio-code"
            ];

            onActivation = {
              autoUpdate = true;
              cleanup = "uninstall";
            };

            taps = builtins.attrNames config.nix-homebrew.taps;
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;

            defaults = {
              ".GlobalPreferences" = {
                # マウス軌道の速さを最速化
                "com.apple.mouse.scaling" = 3.0;
              };
              CustomUserPreferences = {
                "com.apple.desktopservices" = {
                  # ネットワークフォルダに .DS_Store を作成しない
                  DSDontWriteNetworkStores = true;
                };
              };
              dock = {
                # 自動的に非表示
                autohide = true;
                # 位置を右側に設定
                orientation = "right";
                # 永続的なアプリケーション
                persistent-apps = [
                  { app = "/Applications/Google Chrome.app"; }
                  { app = "/Applications/Ghostty.app"; }
                  { app = "/Applications/Visual Studio Code.app"; }
                  { app = "/Applications/DevToys.app"; }
                  { app = "/Applications/1Password.app"; }
                ];
              };
              finder = {
                # すべてのファイル名拡張子を表示
                AppleShowAllExtensions = true;
                # 検索範囲を現在のフォルダに変更
                FXDefaultSearchScope = "SCcf";
                # 拡張子を変更する際の警告を無効化
                FXEnableExtensionChangeWarning = false;
                # デフォルト表示をリストビューに設定
                FXPreferredViewStyle = "Nlsv";
                # 新規ウィンドウのデフォルト表示をHOMEに設定
                NewWindowTarget = "Home";
                # パスバーを表示
                ShowPathbar = true;
              };
              # メニューバーの時計
              menuExtraClock = {
                # 24時間表示に設定
                Show24Hour = true;
              };
              NSGlobalDomain = {
                # F1やF2などのキーを標準のファンクションキーとして使用
                "com.apple.keyboard.fnState" = true;
                # ナチュラルなスクロールを無効化
                "com.apple.swipescrolldirection" = false;
                # アクセント付き文字の「長押し入力」を無効化
                ApplePressAndHoldEnabled = false;
                # すべてのファイル名拡張子を表示
                AppleShowAllExtensions = true;
                # キーリピート開始までの待機時間を最短化
                InitialKeyRepeat = 15;
                # キーリピートの速度を最速化
                KeyRepeat = 2;
                # 自動大文字変換を無効化
                NSAutomaticCapitalizationEnabled = false;
                # スマートダッシュ置換を無効化
                NSAutomaticDashSubstitutionEnabled = false;
                # スマートピリオド置換を無効化
                NSAutomaticPeriodSubstitutionEnabled = false;
                # スマート引用符置換を無効化
                NSAutomaticQuoteSubstitutionEnabled = false;
                # 自動スペル修正を無効化
                NSAutomaticSpellingCorrectionEnabled = false;
              };
              # スクリーンキャプチャ
              screencapture = {
                # ドロップシャドウを無効化
                disable-shadow = true;
                # スクリーンキャプチャの保存先を変更
                location = "~/Downloads/";
                # スクリーンキャプチャのサムネイル表示を無効化
                show-thumbnail = false;
              };
              WindowManager = {
                # 壁紙クリック時のデスクトップ表示を無効化
                EnableStandardClickToShowDesktop = false;
              };
            };

            keyboard = {
              # キーの再マップを有効化
              enableKeyMapping = true;
              # Caps Lock キーを Control キーに再マップ
              remapCapsLockToControl = true;
            };

            # The user used for options that previously applied to the user running darwin-rebuild.
            # This is a transition mechanism as nix-darwin reorganizes its options and will eventually be unnecessary and removed.
            primaryUser = username;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 6;
          };

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
      homeConfiguration =
        { config, pkgs, ... }:
        {
          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };

          home-manager.users.${username} =
            { config, pkgs, ... }:
            {
              home.file = builtins.listToAttrs (
                map
                  (path: {
                    name = path;
                    value = {
                      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/${path}";
                    };
                  })
                  [
                    ".config/atcoder-cli-nodejs"
                    ".config/bat"
                    ".config/ghostty"
                    ".config/git"
                    ".config/karabiner"
                    ".config/nvim"
                    ".config/sheldon"
                    ".config/starship.toml"
                    ".config/yamllint"
                    ".config/zsh-abbr"
                    ".local/bin/rfv"
                    ".local/bin/update-system"
                    ".ripgreprc"
                    ".textlintrc.json"
                    ".vim"
                    ".vimrc"
                    ".zprofile"
                    ".zshenv"
                    ".zshrc"
                    ".zshrc.d"
                  ]
              );

              home.packages = with pkgs; [
                # Command
                bat
                colordiff
                curl
                dos2unix
                exiftool
                eza
                fd
                fzf
                gh
                ghq
                git
                git-lfs
                httpie
                imagemagick
                jq
                lsd
                nkf
                openssh
                p7zip
                ripgrep
                ripgrep-all
                rsync
                sheldon
                sqlite
                ssh-copy-id
                starship
                wget
                zoxide

                # Formatter
                nixfmt-rfc-style
                shfmt
                stylua

                # Linter
                checkmake
                editorconfig-checker
                lua51Packages.luacheck
                shellcheck
                yamllint
              ];

              # The state version is required and should stay at the version you originally installed.
              home.stateVersion = "25.11";

              programs = {
                direnv = {
                  enable = true;
                  nix-direnv.enable = true;
                  silent = true;
                };
                neovim = {
                  enable = true;
                  extraPackages = with pkgs; [
                    basedpyright
                    lua-language-server
                    luarocks
                    tree-sitter
                    typescript-language-server
                    vue-language-server
                  ];
                };
              };
            };
        };
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem =
        { pkgs, ... }:
        {
          formatter = pkgs.nixfmt-tree;
        };
      flake = {
        darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
          modules = [
            nix-homebrew.darwinModules.nix-homebrew
            homebrewConfiguration
            darwinConfiguration
            home-manager.darwinModules.home-manager
            homeConfiguration
          ];
        };
      };
    };
}
