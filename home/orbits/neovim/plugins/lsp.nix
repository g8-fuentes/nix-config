{
  pkgs,
  options,
  outputs,
  ...
}:
let
  onAttachFunction = ''
    local on_attach = function(client, bufnr)
      -- format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("Format", { clear = true }),
          buffer = bufnr,
          callback = function() vim.lsp.buf.format() end
        })
      end
    end  '';
in
{
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    keymaps = [
      {
        action = "<cmd>Lspsaga code_action<CR>";
        key = "<leader>ga";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga peek_definition<CR>";
        key = "<leader>gp";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga goto_definition<CR>";
        key = "<leader>gt";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
        key = "<leader>gk";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
        key = "<leader>gj";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga finder<CR>";
        key = "<leader>gf";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga hover_doc<CR>";
        key = "<leader>gh";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga outline<CR>";
        key = "<leader>go";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>Lspsaga rename<CR>";
        key = "<leader>gr";
        options = {
          silent = true;
        };
      }
    ];
    plugins = {
      lsp = {
        enable = true;
        onAttach = onAttachFunction;
        servers = {
          eslint = {
            enable = true;
            filetypes = [
              ".eslintrc.js"
              ".eslintrc.cjs"
              ".eslintrc.json"
              ".eslintrc"
              "eslint.config.mjs"
            ];
            onAttach.function = onAttachFunction;
          };
          nixd = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          ${
            if (options.programs.nixvim.type.getSubOptions [ ]).plugins.lsp.servers ? ts_ls then
              "ts_ls"
            else
              "tsserver"
          } = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          ts_query_ls.enable = false;
          html = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          cssls = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          tailwindcss = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          graphql = {
            enable = false;
            onAttach.function = onAttachFunction;
          };
          jsonls = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          pyright = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
          lua_ls = {
            enable = true;
            onAttach.function = onAttachFunction;
          };
        };
      };
      lspsaga = {
        enable = true;
        settings = {
          diagnostic = {
            show_code_action = true;
            keys = { };
          };
          code_action = {
            show_server_name = true;
            keys = { };
          };

        };
        definition = {
          keys = { };
        };
        finder = {
          keys = { };
        };
        hover = { };
        lightbulb = { };
        outline = {
          keys = { };
        };
        rename = {
          keys = { };
        };

      };
    };
  };
}
