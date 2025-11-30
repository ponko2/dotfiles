{
  description = "ponko2's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
    }:
    let
      username = "kano";
      hostname = "ponko2-vm";
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          # environment.systemPackages = with pkgs; [ ];

          homebrew = {
            enable = true;

            brews = [
              "basedpyright"
              "bat"
              "checkmake"
              "colordiff"
              "coreutils"
              "curl"
              "diffutils"
              "dos2unix"
              "ed"
              "editorconfig-checker"
              "exiftool"
              "eza"
              "fd"
              "findutils"
              "fnm"
              "fzf"
              "gawk"
              "gh"
              "ghq"
              "git"
              "git-lfs"
              "gnu-sed"
              "gnu-tar"
              "go"
              "golangci-lint"
              "grep"
              "gzip"
              "httpie"
              "imagemagick"
              "iproute2mac"
              "jq"
              "lsd"
              "lua-language-server"
              "luacheck"
              "luarocks"
              "mysql-client"
              "neovim"
              "nkf"
              "openssh"
              "p7zip"
              "ripgrep"
              "ripgrep-all"
              "rsync"
              "sheldon"
              "shellcheck"
              "shfmt"
              "sqlite"
              "ssh-copy-id"
              "starship"
              "stylua"
              "tree-sitter"
              "typescript-language-server"
              "vim"
              "vue-language-server"
              "watch"
              "wget"
              "yamllint"
              "zoxide"
              "zsh"
            ];

            casks = [
              # GUI Applications
              # "xquartz"
              # "1password"
              # "1password-cli"
              # "adobe-acrobat-reader"
              # "appcleaner"
              "devtoys"
              # "docker"
              "ghostty"
              "iterm2"
              "karabiner-elements"
              "monitorcontrol"
              "mysqlworkbench"
              "rectangle"
              "sequel-ace"
              # "the-unarchiver"
              "visual-studio-code"
              # Fonts
              "font-udev-gothic"
              "font-udev-gothic-nf"
            ];

            # masApps = {
            #   "Monosnap" = 540348655;
            # };

            onActivation = {
              autoUpdate = true;
              cleanup = "uninstall";
            };
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
              WindowManager = {
                # 壁紙クリック時のデスクトップ表示を無効化
                EnableStandardClickToShowDesktop = false;
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
              # スクリーンキャプチャ
              screencapture = {
                # ドロップシャドウを無効化
                disable-shadow = true;
                # スクリーンキャプチャの保存先を変更
                location = "~/Downloads/";
                # スクリーンキャプチャのサムネイル表示を無効化
                show-thumbnail = false;
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

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };

          home-manager.users.${username} =
            { config, pkgs, ... }:
            let
              dotfiles = builtins.listToAttrs (
                map
                  (path: {
                    name = path;
                    value = {
                      source = "${config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home"}/${path}";
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
            in
            {
              home.file = dotfiles;

              home.packages = with pkgs; [
                nixfmt-rfc-style
              ];

              # The state version is required and should stay at the version you originally installed.
              home.stateVersion = "25.11";
            };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#<hostname>
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
        ];
      };
    };
}
