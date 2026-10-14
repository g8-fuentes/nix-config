{ options, outputs, ... }: {
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    plugins = {
      lint = {
        enable = true;
        lintersByFt = {
          markdown = [ "vale" ];
          nix = [ "nix" ];
          javascript = [ "eslint_d" ];
          typescript = [ "eslint_d" ];
          javascriptreact = [ "eslint_d" ];
          typescriptreact = [ "eslint_d" ];
          svelte = [ "eslint_d" ];
          python = [ "pylint" ];
        };
        autoCmd = {
          callback = {
            __raw = ''
              function()
                require('lint').try_lint()
              end
            '';
          };
          event = "BufWritePost";
        };
        linters = {
          eslint_d = {
            args = [
              "--no-warn-ignored"
              "--format"
              "json"
              "--stdin"
              "--stdin-filename"
            ];
          };
        };

      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            css = [ "prettierd" ];
            graphql = [ "prettierd" ];
            html = [ "prettierd" ];
            javascript = [ "prettierd" ];
            javascriptreact = [ "prettierd" ];
            json = [ "prettierd" ];
            lua = [ "stylua" ];
            markdown = [ "prettierd" ];
            nix = [ "nixfmt" ];
            python = [
              "ruff_fix"
              "ruff_format"
            ];
            svelte = [ "prettierd" ];
            typescript = [ "prettierd" ];
            typescriptreact = [ "prettierd" ];
            yaml = [ "prettierd" ];

          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
            async = false;
          };
        };

      };
    };
  };
}
