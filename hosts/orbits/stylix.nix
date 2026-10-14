{ pkgs, ... }:
let
  theme = import ../../theme.nix { inherit pkgs; };
in
{
  _module.args.theme = theme;

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = theme.polarity;
    base16Scheme = theme.base16Scheme;
    fonts.monospace = theme.monospace;
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
    };
    override = { };
    targets = {
      console.enable = true;
      grub.useImage = true;
    };
  };

}
