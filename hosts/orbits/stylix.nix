{ pkgs, ... }:
let
  cursorName = "Bibata-Modern-Ice";
  cursorPkg = pkgs.bibata-cursors;
  base16SchemeDefault = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";

in
{

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = base16SchemeDefault;
    fonts = {
      monospace = {
        name = "JetBrainsMonoNL Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
    };
    override = { };
    targets = {
      console.enable = true;
    };
  };

}
