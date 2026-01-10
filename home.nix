{ config, pkgs, ... }:
{
  home = {
    file =
      pkgs.lib.genAttrs
        [
          ".config/aerospace"
          ".config/atcoder-cli-nodejs"
          ".config/bat"
          ".config/ghostty"
          ".config/git"
          ".config/jj"
          ".config/karabiner"
          ".config/nvim"
          ".config/sheldon"
          ".config/starship.toml"
          ".config/yamllint"
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
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/${name}";
        });
    packages = with pkgs; [
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
      git-lfs
      httpie
      imagemagick
      jq
      jujutsu
      lsd
      nb
      nh
      nix-output-monitor
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
    ];
    stateVersion = "25.11";
  };
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
        nixd
        tree-sitter
        typescript-language-server
        vue-language-server
      ];
    };
  };
}
