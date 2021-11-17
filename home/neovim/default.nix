{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
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
    ];
  };

  home.sessionVariables.EDITOR = "nvim";
  home.packages = with pkgs; [
    nixpkgs-fmt
    python3
    python3Packages.ipython
    python3Packages.pylint
    nodePackages.pyright
  ];

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON {
    rust-analyzer.serverPath = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    clangd = {
      path = "${pkgs.clang-tools}/bin/clangd";
      semanticHighlighting = true;
    };
    languageserver.nix = {
      command = "${pkgs.rnix-lsp}/bin/rnix-lsp";
      filetypes = [ "nix" ];
    };
  };
}
