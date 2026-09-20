{ config, pkgs, ... }:
{
  home = {
    file =
      pkgs.lib.genAttrs
        [
          ".config/bat"
          ".config/direnv"
          ".config/ghostty"
          ".config/git"
          ".config/herdr"
          ".config/jj"
          ".config/karabiner"
          ".config/mise"
          ".config/nvim"
          ".config/omniwm"
          ".config/process-compose"
          ".config/sheldon"
          ".config/snapzy"
          ".config/starship.toml"
          ".config/tuicr"
          ".config/yamllint"
          ".config/yazi"
          ".config/zed"
          ".config/zsh-abbr"
          ".local/bin/rfv"
          ".local/bin/update-system"
          ".nbrc"
          ".ripgreprc"
          ".textlintrc.json"
          ".vim"
          ".vimrc"
          ".zprofile"
          ".zshenv"
          ".zshrc"
          ".zshrc.d"
        ]
        (name: {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/${name}";
        });
    packages = with pkgs; [
      bat
      checkmake
      colordiff
      curl
      deadnix
      direnv
      dos2unix
      editorconfig-checker
      exiftool
      eza
      fd
      fzf
      gh
      ghq
      git-lfs
      hk
      httpie
      imagemagick
      jq
      jujutsu
      lsd
      lua51Packages.luacheck
      nb
      nh
      nix-direnv
      nix-output-monitor
      nixfmt
      nkf
      p7zip
      process-compose
      ripgrep
      ripgrep-all
      rsync
      selene
      sheldon
      shellcheck
      shfmt
      sqlite
      ssh-copy-id
      starship
      statix
      wget
      yamllint
      yazi
      zoxide
    ];
    stateVersion = "25.11";
  };
  launchd.agents = {
    # あらゆるSSHクライアントから1PasswordのSSHエージェントを使えるようにする
    SSH_AUTH_SOCK = {
      enable = true;
      config = {
        ProgramArguments = [
          "/bin/sh"
          "-c"
          ''/bin/ln -sf "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" "$SSH_AUTH_SOCK"''
        ];
        RunAtLoad = true;
      };
    };
  };
  programs = {
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        clippy
        coreutils-prefixed
        lua-language-server
        luarocks
        nixd
        pkl
        pkl-lsp
        rust-analyzer
        stylua
        tree-sitter
        ty
        vscode-langservers-extracted
        vtsls
        vue-language-server
      ];
      sideloadInitLua = true;
      withPython3 = true;
      withRuby = true;
    };
  };
}
