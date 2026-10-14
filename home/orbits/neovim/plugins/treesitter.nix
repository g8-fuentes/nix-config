{
  pkgs,
  config,
  options,
  outputs,
  ...
}:
{
  programs.nixvim = outputs.lib.existing (options.programs.nixvim.type.getSubOptions [ ]) {
    plugins.treesitter = {
      enable = true;
      package = pkgs.vimPlugins.nvim-treesitter;
      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
      ];
      highlight = {
        enable = true;
      };

      settings = {
        auto_install = false;
        autotag = true;
        ensure_installed = null;
        ignore_install = [ ];
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = false;
            node_decremental = "grm";
            node_incremental = "grn";
            scope_incremental = "grc";
          };
        };
        indent = {
          enable = true;
        };
        sync_install = false;
      };
    };
  };
}
