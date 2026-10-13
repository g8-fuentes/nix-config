{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  "*" = {
    border-radius = mkLiteral "2px";
  };

  "configuration" = {
    modi = "run,drun,window";
    show-icons = true;
    drun-display-format = "{icon} {name}";
    location = 0;
    disable-history = false;
    hide-scrollbar = true;
    display-drun = "   Applications ";
    display-run = "   Run ";
    display-window = " 﩯  Window";
    display-Network = " 󰤨  Network";
    sidebar-mode = true;
  };
  "element-text, element-icon , mode-switcher" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };
  "window" = {
    height = mkLiteral "400px";
    width = mkLiteral "700px";
    border = mkLiteral "3px";
    border-radius = mkLiteral "8px";
    border-color = mkLiteral "#${config.lib.stylix.colors.base06}";

  };
  "inputbar" = {
    children = map mkLiteral [
      "prompt"
      "entry"
    ];
    padding = mkLiteral "2px";
  };

  "prompt" = {
    padding = mkLiteral "6px";
    margin = mkLiteral "20px 0px 0px 20px";
  };
  "textbox-prompt-colon" = {
    expand = false;
    str = ":";
  };
  "entry" = {
    padding = mkLiteral "6px";
    margin = mkLiteral "20px 0px 0px 10px";
  };
  "listview" = {
    border = mkLiteral "0px 0px 0px";
    padding = mkLiteral "6px 0px 0px";
    margin = mkLiteral "10px 20px 0px 20px";
    columns = 2;
    lines = 5;

  };
  "element" = {
    padding = mkLiteral "5px";
  };
  "element-icon" = {
    size = mkLiteral "25px";
  };
  "mode-switcher" = {
    spacing = 0;
  };
  "button" = {
    padding = mkLiteral "10px";
    vertical-align = mkLiteral "0.5";
    horizontal-align = mkLiteral "0.5";

  };
  "message" = {
    margin = mkLiteral "2px";
    padding = mkLiteral "2px";
  };
  "textbox" = {
    padding = mkLiteral "6px";
    margin = mkLiteral "20 px 0 px 0 px 20px";

  };
}
