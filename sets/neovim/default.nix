{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = builtins.readFile ./init.vim;
      packages.default.start = with pkgs.vimPlugins; [
        coc-nvim
        editorconfig-vim
        fzf-vim
        vim-airline
        vim-airline-themes
        vim-clang-format
        vim-fetch
        vim-nftables
        vim-nix
        vim-sensible
        vim-toml

        coc-go
        coc-json
        coc-rust-analyzer
      ];
    };
  };
}
