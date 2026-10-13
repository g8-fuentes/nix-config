{
  pkgs,
  lib,
  config,
  ...
}:
let
  fromGithub =
    rev: ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "${repo}";
        ref = ref;
        rev = rev;
      };
    };
  theme = import ../../../theme.nix { inherit pkgs; };
in
{
  imports = [
    ./keymaps.nix
    ./settings.nix
    ./plugins/bufferline.nix
    ./plugins/cmp.nix
    ./plugins/lint.nix
    ./plugins/lsp.nix
    ./plugins/neorg.nix
    ./plugins/noice.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/yazi.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    package = pkgs.neovim-unwrapped;

    colorschemes.tokyonight = {
      enable = true;
      settings.style = theme.variant;
    };

    extraLuaPackages =
      luaPkgs: with luaPkgs; [
        lua-utils-nvim
        nvim-nio
        pathlib-nvim
      ];

    plugins = {

      dashboard.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      transparent.enable = true;
      web-devicons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      zen-mode-nvim
      material-nvim
    ];

    extraPackages = with pkgs; [
      typescript-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      lua-language-server
      nixd
      ruff
      nixfmt
      prettierd
      stylua
      pylint
      eslint_d
    ];

    opts = {
      ai = true;
      backup = false;
      backupskip = "/tmp";
      backspace = "start,eol,indent";
      breakindent = true;
      clipboard = "unnamedplus";
      cmdheight = 1;
      encoding = "utf-8";
      expandtab = true;
      foldmethod = "indent";
      foldlevel = 99;
      fileencoding = "utf-8";
      hlsearch = true;
      inccommand = "split";
      ignorecase = true;
      laststatus = 2;
      number = true;
      scrolloff = 999;
      shell = "zsh";
      shiftwidth = 2;
      showcmd = true;
      si = true;
      smarttab = true;
      splitbelow = true;
      splitright = true;
      tabstop = 4;
      title = true;
      wrap = true;
    };
  };

  home.sessionVariables.EDITOR = "nvim";
}
