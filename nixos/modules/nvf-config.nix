{ config, pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    
    settings = {
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.filetree.neo-tree.enable = true;

      vim.theme = {
        enable = true;
        name = "mellow";
        style = "moon";
      };

      vim.languages = {
        enableTreesitter = true;

        nix = {
          enable = true;
          lsp.enable = true;
          format.enable = true;
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
    };
  };
}
