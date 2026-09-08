{ config, pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings = {
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.filetree.neo-tree.enable = true;
      vim.autopairs.nvim-autopairs.enable = true;

      vim.theme = {
        enable = true;
        name = "mellow";
        style = "moon";
      };

      vim.languages = {
        enableTreesitter = true;

        nix = {
          enable = true;
          format.enable = true;
          extraDiagnostics.enable = true;

          lsp = {
            enable = true;
            servers = [ "nixd" ]; # Preferred over nil
          };
        };
      };

      vim.options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
      };
      
      vim.lsp.enable = true;

      vim.autocomplete.nvim-cmp = {
        enable = true;
        sourcePlugins = [ ];
      };
      vim.snippets.luasnip.enable = true;

      vim.diagnostics = {
        enable = true;

        config = {
          virtual_text = false;
          virtual_lines = {
            current_line = true;
          };
          signs = true;
          underline = true;
          update_in_insert = false;
        };
      };

      vim.git = {
        gitsigns = {
          enable = true;

          setupOpts = {
            current_line_blame = true;
          };
        };
      };

      # ==== Plugis Section ====
      vim.extraPlugins = {

        # auto-save.nvim
        auto-save = {
          package = pkgs.vimPlugins.auto-save-nvim;
          setup = ''require('auto-save').setup {
            enabled = true,
            trigger_events = {
              immediate_save = { "BufLeave", "FocusLost" },
              defer_save = { "InsertLeave", "TextChanged" },
              cancel_defered_save = { "InsertEnter" },
            },
          }'';
        };
      };
    };
  };
}
