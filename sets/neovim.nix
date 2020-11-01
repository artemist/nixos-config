{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    configure.customRC = "source ~/.config/nvim/init.vim\n";
  };
}
