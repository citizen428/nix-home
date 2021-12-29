{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "me";
  home.homeDirectory = "/home/nixos";

  home.file = {
    "./.asdfrc".source = ./dotfiles/asdfrc;
    "./.config/nvim".source = ./nvim-config;
    "./.default-gems".source = ./dotfiles/default-gems;
    "./.gitattributes".source = ./dotfiles/gitattributes;
    "./.gitconfig".source = ./dotfiles/gitconfig;
    "./.gitignore".source = ./dotfiles/gitignore;
    "./.pryrc".source = ./dotfiles/pryrc;
    "./.psqlrc".source = ./dotfiles/psqlrc;
    "./.tmux.conf".source = ./dotfiles/tmux.conf;
  };

  home.packages = [
    pkgs.asdf-vm
    pkgs.bat
    pkgs.exa
    pkgs.fzf
    pkgs.fishPlugins.foreign-env
    pkgs.fnm
    pkgs.htop
    pkgs.starship
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
  };
}
