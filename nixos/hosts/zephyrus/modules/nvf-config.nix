{
  pkgs,
  ...
}:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      filetree.neo-tree.enable = true;
      autopairs.nvim-autopairs.enable = true;

      # Leader key
      globals.mapleader = " ";

      theme = {
        enable = true;
        name = "mellow";
        style = "moon";
      };

      languages = {
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
            type = [ "alejandra" ];
          };
        };

        python = {
          enable = true;
          dap.enable = true;
          lsp.enable = true;
          format.enable = true;
        };

        yaml = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
      };

      lsp = {
        enable = true;
        presets.harper.enable = true;
        formatOnSave = true;
      };

      autocomplete.nvim-cmp = {
        enable = true;
        sourcePlugins = [ ];
      };
      snippets.luasnip.enable = true;

      diagnostics = {
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

      git = {
        gitsigns = {
          enable = true;

          setupOpts = {
            current_line_blame = true;
          };
        };
      };

      # ==== Plugins Section ====

      # Better comments
      notes.todo-comments.enable = true;
      tabline.nvimBufferline = {
        enable = true;
        mappings.closeCurrent = "<leader>bd";
      };
      binds.whichKey.enable = true;

      extraPlugins = {

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
