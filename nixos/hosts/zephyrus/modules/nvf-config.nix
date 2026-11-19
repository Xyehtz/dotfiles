{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [python314Packages.debugpy];

  programs.nvf = {
    enable = true;

    settings.vim = {
      statusline.lualine.enable = true;
      telescope.enable = true;
      autopairs.nvim-autopairs.enable = true;

      keymaps = [
        {
          key = "<leader>tw";
          mode = "n";
          action = ":Twilight<CR>";
          desc = "Toggle Twilight";
        }
      ];

      filetree.nvimTree = {
        enable = true;
        mappings.toggle = "<leader>g";
      };

      utility = {
        yazi-nvim.enable = true;
      };

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

        markdown = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
          extensions = {
            markview-nvim.enable = true;
          };
        };

        zig = {
          enable = true;
          dap.enable = true;
          lsp.enable = true;
        };

        bash = {
          enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        rust = {
          enable = true;
          dap.enable = true;
          extensions = {
            crates-nvim.enable = true;
          };
          format.enable = true;
          lsp.enable = true;
        };
      };

      options = {
        tabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        foldlevel = 99;
      };

      lsp = {
        enable = true;
        formatOnSave = true;

        # Create a custom server for SourceKit and Swift LSP
        servers.sourcekit = {
          cmd = ["${pkgs.sourcekit-lsp}/bin/sourcekit-lsp"];
          filetypes = ["swift"];
        };

        presets = {
          harper.enable = true;

          # Zig
          zls.enable = true;
        };

        otter-nvim.enable = true;
      };

      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      autocomplete.blink-cmp = {
        enable = true;
        setupOpts.sources.default = ["lsp" "path" "snippets" "buffer"];
      };
      snippets.luasnip.enable = true;

      # Visual plugins
      visuals = {
        fidget-nvim.enable = true;
        indent-blankline.enable = true;
        rainbow-delimiters.enable = true;
        satellite-nvim.enable = true;

        # Icons
        nvim-web-devicons.enable = true;
        tiny-devicons-auto-colors.enable = true;

        # Twilight configuration
        twilight-nvim.enable = true;
      };

      ui = {
        modes-nvim.enable = true;
        illuminate.enable = true;
      };

      diagnostics = {
        enable = true;

        config = {
          virtual_text = true;
          signs = true;
          update_in_insert = true;
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

      binds = {
        whichKey.enable = true;
        hardtime-nvim.enable = true;
      };

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

        promise-async.package = pkgs.vimPlugins.promise-async;
      };

      lazy.plugins."nvim-ufo" = {
        package = pkgs.vimPlugins.nvim-ufo;
        setupModule = "ufo";
        setupOpts = {};
      };
    };
  };
}
