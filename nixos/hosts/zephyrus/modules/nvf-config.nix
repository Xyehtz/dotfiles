{pkgs, ...}: {
  home.packages = with pkgs; [python314Packages.debugpy];

  programs.nvf = {
    enable = true;

    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      filetree.neo-tree.enable = true;
      autopairs.nvim-autopairs.enable = true;

      treesitter = {
        enable = true;

        # Treesitter grammar for Swift
        grammars = [pkgs.vimPlugins.nvim-treesitter-parsers.swift];
      };

      # Leader key
      globals.mapleader = " ";

      theme = {
        enable = true;
        name = "rose-pine";
        style = "main";
      };

      languages = {
        enableTreesitter = true;

        nix = {
          enable = true;
          extraDiagnostics.enable = true;

          lsp = {
            enable = true;
            servers = ["nixd"]; # Preferred over nil
          };

          format = {
            enable = true;
            type = ["alejandra"];
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

        go = {
          enable = true;
          extensions.gopher-nvim.enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        env = {
          enable = true;
          extraDiagnostics.enable = true;
        };

        fish = {
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

        # Create a custom server for SourceKit and Swift LSP
        servers.sourcekit = {
          cmd = ["${pkgs.sourcekit-lsp}/bin/sourcekit-lsp"];
          filetypes = ["swift"];
        };
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      autocomplete.nvim-cmp = {
        enable = true;
        sourcePlugins = [];
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
