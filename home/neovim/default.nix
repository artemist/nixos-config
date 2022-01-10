{ config, pkgs, ... }:

let
  lsp-colors = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "lsp-colors.nvim";
    version = "2021-10-22";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "lsp-colors.nvim";
      rev = "517fe3ab6b63f9907b093bc9443ef06b56f804f3";
      sha256 = "vXX9/5hulIlDwE9ISZlTMxxrl+Jjyquagv5+AHmEA5c=";
      fetchSubmodules = false;
    };
    meta.homepage = "https://github.com/folke/lsp-colors.nvim";
  };
in
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.replaceStrings
      [ "{{CLANGDPATH}}" ] [ "${pkgs.clang-tools}/bin/clangd" ]
      (builtins.readFile ./init.vim));
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      fzf-vim
      vim-airline
      vim-clang-format
      vim-fish
      vim-fetch
      vim-nftables
      vim-nix
      vim-sensible
      vim-toml
      meson
      gruvbox

      nvim-lspconfig
      nvim-compe
      lsp-colors
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    nixpkgs-fmt
    python3
    python3Packages.ipython
    python3Packages.pylint
    nodePackages.pyright
    rust-analyzer
    rnix-lsp
  ];

}
