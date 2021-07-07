{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with pkgs.vimPlugins; [
      coc-nvim
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

      coc-clangd
      vim-lsp-cxx-highlight

      coc-json
      coc-rust-analyzer
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON {
    rust-analyzer.serverPath = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    clangd = {
      path = "${pkgs.llvmPackages_latest.clang-unwrapped}/bin/clangd";
      semanticHighlighting = true;
    };
    languageserver.nix = {
      command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
      filetypes = [ "nix" ];
    };
  };
}
