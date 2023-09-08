{ pkgs, inputs, ... }:

{
  imports = [ inputs.nixvim.nixosModules.nixvim ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs.nixvim = {
    enable = true;
    vimAlias = true;

    # Basic editing / QoL
    editorconfig.enable = true;
    colorschemes.kanagawa.enable = true;
    plugins = {
      nix.enable = true;
      fugitive.enable = true;
      gitgutter.enable = true;
      lualine.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      vim-fetch
      vim-fish
      vim-flatbuffers
      vim-nftables
      vim-protobuf
      vim-toml
    ];
    options = {
      hidden = true;
      backup = false;
      writebackup = false;
      cmdheight = 2;
      shortmess = "filnxtToOFc";
      signcolumn = "yes";
      number = true;
    };

    # LSP
    plugins.rust-tools = {
      enable = true;
      server.standalone = false;
    };
    plugins.clangd-extensions.enable = true;
    plugins.lsp = {
      enable = true;
      servers = {
        clangd.enable = true;
        java-language-server.enable = true;
        nil_ls.enable = true;
        pylsp.enable = true;
        texlab.enable = true;
        jsonls.enable = true;
      };

      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>rk" = "goto_prev";
          "<leader>rj" = "goto_next";
        };
        lspBuf = {
          K = "hover";
          gD = "declaration";
          gd = "definition";
          gt = "type_definition";
          gr = "references";
          gi = "implementation";
          "<leader>ra" = "code_action";
          "<leader>rn" = "rename";
          "<leader>rs" = "signature_help";
          "<leader>f" = "format";
        };
      };

      onAttach = ''
        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = bufnr,
                group = "lsp_document_highlight",
                desc = "Clear All the References",
            })
        end
      '';
    };

    # Autocomplete
    plugins = {
      cmp-cmdline.enable = true;
      cmp-git.enable = true;
      cmp-buffer.enable = true;
      nvim-cmp = {
        enable = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "calc"; }
          { name = "emoji"; }
        ];
        mappingPresets = [ "insert" "cmdline" ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
        };
      };
    };

    # For some reason you can't do this directly in nix?
    extraConfigLuaPost = ''
      do
        local cmp = require('cmp')
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' },
          }, {
            { name = 'buffer' },
          })
        })

        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      end
    '';
  };
}
