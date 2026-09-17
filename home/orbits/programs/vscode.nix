{ pkgs, ... }:
let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  symbols = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "symbols";
      publisher = "miguelsolorio";
      version = "0.0.24";
      sha256 = "sha256-yEE6G2e/a2/DcKq1+Vtv0YIAtWZG5LyXfZ6cbheRV1g=";
    };
  };

  carbonfox = buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "nightfox-theme-collections";
      publisher = "nuromirg";
      version = "1.0.7";
      sha256 = "sha256-prKqcZrVQA2K88HzP2fy/YTBnxMkZy5si8mg0/quWEM=";
    };
  };

in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = true;
      extensions = with pkgs.vscode-extensions; [
        # theme
        carbonfox
        symbols
        # git
        donjayamanne.githistory
        eamodio.gitlens
        ms-vsliveshare.vsliveshare

        # lint
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        davidanson.vscode-markdownlint

        # extra language plugins
        bradlc.vscode-tailwindcss
        naumovs.color-highlight
        jnoortheen.nix-ide

      ];
      keybindings = [ ];
      userSettings = {
        "breadcrumbs.enabled" = true;

        "editor.fontSize" = 14;
        "editor.lineHeight" = 1.6;
        "editor.tabSize" = 2;
        "editor.minimap.enabled" = true;
        "editor.wordWrap" = "on";
        "editor.glyphMargin" = false;
        "editor.fontFamily" = "MonoLisa";
        "editor.renderLineHighlight" = "gutter";
        "editor.fontLigatures" = true;
        "editor.semanticHighlighting.enabled" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.scrollbar.vertical" = "hidden";
        "editor.formatOnSave" = true;
        "editor.codeActionsOnSave" = {
          "source.fixAll.eslint" = "always";
          "source.removeUnusedImports" = "always";
          "source.organizeImports" = "always";
        };

        "explorer.compactFolders" = false;
        "explorer.fileNesting.enabled" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;

        "eslint.validate" = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];

        "git.confirmSync" = false;
        "github.copilot.nextEditSuggestions.enabled" = true;

        "js/ts.updateImportsOnFileMove.enabled" = "always";
        "terminal.integrated.fontFamily" = "JetBrainsMonoNL Nerd Font";
        "terminal.integrated.fontSize" = 13;
        "terminal.integrated.fontLigatures.enabled" = true;

        "window.titleBarStyle" = "native";
        "window.commandCenter" = false;
        "workbench.colorTheme" = "Carbonfox";
        "workbench.iconTheme" = "symbols";
        "workbench.startupEditor" = "newUntitledFile";
        "workbench.editor.labelFormat" = "short";
        "workbench.statusBar.visible" = true;
        "workbench.layoutControl.enabled" = true;

        "zenMode.fullScreen" = false;
        "zenMode.centerLayout" = false;
        "zenMode.showTabs" = "single";

        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };

      };
    };

  };
}
