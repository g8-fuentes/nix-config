# HOSTS STYLIX

{ pkgs, ... }:
let
  cursorName = "Bibata-Modern-Ice";
  cursorPkg = pkgs.bibata-cursors;
  base16SchemeDefault = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";

in
{

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = base16SchemeDefault;
    # cursor = {
    #   name = cursorName;
    #   package = cursorPkg;
    #   size = 24;
    # };
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
