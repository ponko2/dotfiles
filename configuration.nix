{
  config,
  inputs,
  pkgs,
  user,
  ...
}:
{
  environment = {
    etc.nix-darwin.source = "${user.home}/dotfiles";
    systemPackages = with pkgs; [
      appcleaner
      brewCasks.devtoys
      brewCasks.docker-desktop
      ghostty-bin
      google-chrome
      karabiner-elements
      monitorcontrol
      rectangle
      vscode
    ];
  };
  fonts.packages = with pkgs; [
    udev-gothic
    udev-gothic-nf
  ];
  homebrew = {
    enable = true;
    casks = [ ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    taps = builtins.attrNames config.nix-homebrew.taps;
  };
  nix = {
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings.experimental-features = "nix-command flakes";
  };
  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
    user = user.name;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };
  programs = {
    _1password.enable = true;
    _1password-gui.enable = true;
  };
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };
  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
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
          { app = "${pkgs.google-chrome}/Applications/Google Chrome.app"; }
          { app = "${pkgs.ghostty-bin}/Applications/Ghostty.app"; }
          { app = "${pkgs.vscode}/Applications/Visual Studio Code.app"; }
          { app = "${pkgs.brewCasks.devtoys}/Applications/DevToys.app"; }
          { app = "${pkgs._1password-gui}/Applications/1Password.app"; }
        ];
        # 最近使用したアプリケーションを非表しない
        show-recents = false;
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
        # ステータスバーを表示
        ShowStatusBar = true;
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
    primaryUser = user.name;
    stateVersion = 6;
  };
  users.users.${user.name} = user;
}
