{ config, pkgs, pkgs-unstable, ... }:

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
in {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = (builtins.replaceStrings [ "{{CLANGDPATH}}" "{{JLSPATH}}" ] [
      "${pkgs.clang-tools}/bin/clangd"
      "${pkgs.java-language-server}/bin/java-language-server"
    ] (builtins.readFile ./init.vim));
    plugins = with pkgs.vimPlugins; [
      editorconfig-vim
      fzf-vim
      gruvbox
      meson
      vim-airline
      vim-clang-format
      vim-fetch
      vim-fish
      vim-flatbuffers
      vim-nftables
      vim-nix
      vim-protobuf
      vim-sensible
      vim-toml

      nvim-lspconfig
      nvim-compe
      lsp-colors
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  home.packages = with pkgs; [
    nixpkgs-fmt
    python3
    python3Packages.ipython
    python3Packages.pylint
    nodePackages.pyright
    pkgs-unstable.rust-analyzer
    rnix-lsp
  ];

}
