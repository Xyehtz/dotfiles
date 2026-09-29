# NOTE: This is an AI assisted migration of the NVF settings I use
{
  pkgs,
  lib,
  ...
}: let
  codeIndentation = {
    tab-width = 2;
    unit = "  ";
  };
  pythonWithDebugpy = pkgs.python314.withPackages (ps: [ps.debugpy]);

in {
  programs.helix = {
    enable = true;

    # Language servers, formatters and debug adapters Helix will shell out to
    extraPackages = with pkgs; [
      # Nix
      nixd
      alejandra

      # Python
      basedpyright
      black
      pythonWithDebugpy

      # YAML
      yaml-language-server
      prettier

      # Go
      gopls
      gofumpt
      golangci-lint
      golangci-lint-langserver
      delve

      # Fish
      fish-lsp
      fish

      # Grammar
      harper

      # Swift
      sourcekit-lsp
    ];

    settings = {
      theme = "rose_pine";

      editor = {
        auto-pairs = true;
        bufferline = "always";
        gutters = ["diagnostics" "spacer" "line-numbers" "spacer" "diff"];
        end-of-line-diagnostics = "disable";
        inline-diagnostics.cursor-line = "hint";
        line-number = "relative";

        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
            timeout = 1000;
          };
        };

        statusline = {
          left = ["mode" "spinner" "file-type" "file-name" "file-modification-indicator"];
          center = ["diagnostics"];
          right = ["version-control" "selections" "position-percentage" "position" "file-encoding"];
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        auto-info = true;
        soft-wrap.enable = true;
      };

      keys.normal.space = {
        b = {
          b = "buffer_picker";
          d = ":buffer-close";
          n = ":buffer-next";
          p = ":buffer-previous";
        };
      };
    };

    languages = {
      language-server = {
        nixd.command = "nixd";

        # Custom SourceKit server for Swift
        sourcekit-lsp.command = "${pkgs.sourcekit-lsp}/bin/sourcekit-lsp";

        harper-ls = {
          command = "harper-ls";
          args = ["--stdio"];
        };

        fish-lsp = {
          command = "fish-lsp";
          args = ["start"];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          indent = codeIndentation;
          language-servers = ["nixd"];
          formatter.command = lib.getExe pkgs.alejandra;
        }
        {
          name = "python";
          auto-format = true;
          indent = codeIndentation;
          language-servers = ["basedpyright"];
          formatter = {
            command = "black";
            args = ["--quiet" "-"];
          };
          debugger = {
            name = "debugpy";
            transport = "stdio";
            command = "${pythonWithDebugpy}/bin/python";
            args = ["-m" "debugpy.adapter"];
            templates = [
              {
                name = "source";
                request = "launch";
                completion = [
                  {
                    name = "entrypoint";
                    completion = "filename";
                    default = ".";
                  }
                ];
                args = {
                  mode = "debug";
                  program = "{0}";
                };
              }
            ];
          };
        }
        {
          name = "yaml";
          auto-format = true;
          indent = codeIndentation;
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "prettier";
            args = ["--parser" "yaml"];
          };
        }
        {
          name = "go";
          auto-format = true;
          language-servers = ["gopls" "golangci-lint-lsp"];
          formatter.command = "gofumpt";
        }
        {
          name = "fish";
          auto-format = true;
          indent = codeIndentation;
          language-servers = ["fish-lsp"];
          formatter = {
            command = "fish_indent";
          };
        }
        {
          name = "swift";
          indent = codeIndentation;
          language-servers = ["sourcekit-lsp"];
        }
        {
          name = "markdown";
          language-servers = ["marksman" "harper-ls"];
        }
        {
          name = "git-commit";
          language-servers = ["harper-ls"];
        }
      ];
    };
  };
}
