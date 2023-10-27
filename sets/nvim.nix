{ pkgs, ... }:

{
  vimAlias = true;

  # Basic editing / QoL
  editorconfig.enable = true;
  colorschemes.kanagawa.enable = true;
  plugins = {
    nix.enable = true;
    fugitive.enable = true;
    gitgutter.enable = true;
    lualine.enable = true;
    typst-vim.enable = true;
    telescope = {
      enable = true;
      keymaps = {
        "<leader>tgf" = "git_files";
        "<leader>tb" = "buffers";
        "<leader>tl" = "live_grep";
        "<leader>ts" = "grep_string";
        "<leader>tf" = "find_files";
        "<leader>tt" = "builtin";

        gd = "lsp_definitions";
        gt = "lsp_type_definitions";
        gr = "lsp_references";
        gi = "lsp_implementations";
        gcd = "diagnostics";
        gsd = "lsp_document_symbols";
        gsw = "lsp_workspace_symbols";
        gci = "lsp_incoming_calls";
        gco = "lsp_outgoing_calls";

        "<leader>tgs" = "git_status";
        "<leader>tgb" = "git_branches";
        "<leader>tgc" = "git_commits";
      };
    };
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
      jsonls.enable = true;
      nil_ls.enable = true;
      pylsp.enable = true;
      texlab.enable = true;
      tsserver.enable = true;
      typst-lsp.enable = true;
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
    luasnip.enable = true;
    cmp-cmdline.enable = true;
    cmp-git.enable = true;
    cmp-buffer.enable = true;
    nvim-cmp = {
      enable = true;
      snippet.expand = "luasnip";
      sources = [
        { name = "luasnip"; }
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
}
