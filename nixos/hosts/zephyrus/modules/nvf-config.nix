{
  config,
  pkgs,
  lib,
  ...
}:

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
          extraDiagnostics.enable = true;

          lsp = {
            enable = true;
            servers = [ "nixd" ]; # Preferred over nil
          };

          format = {
            enable = true;
            type = [ "nixfmt" ];
          };
        };
      };

      vim.options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
      };

      vim.lsp = {
        enable = true;
        presets.harper.enable = true;
        formatOnSave = true;
      };

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

      # ==== Plugins Section ====
      vim.extraPlugins = {

        # Autosave for Neovim
        auto-save = {
          package = pkgs.vimPlugins.auto-save-nvim;
          setup = ''
            require('auto-save').setup {
              enabled = true,
              trigger_events = {
              immediate_save = { "BufLeave", "FocusLost" },
              defer_save = { "InsertLeave", "TextChanged" },
              cancel_deferred_save = { "InsertEnter" },
              },
            }'';
        };
      };
    };
  };
}
