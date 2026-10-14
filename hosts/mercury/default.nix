{ inputs, pkgs, ... }:
let
  theme = import ../../theme.nix { inherit pkgs; };
  c = theme.colors;
in
{
  imports = [ ../astronauts/droid.nix ];

  environment.packages = [
    inputs.home-manager-droid.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.git
    pkgs.nh
  ];

  environment.etcBackupExtension = ".bak";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  terminal = {
    font = "${theme.monospace.package}/share/fonts/truetype/NerdFonts/JetBrainsMonoNLNerdFont-Regular.ttf";
    colors = {
      background = c.base00;
      foreground = c.base05;
      cursor = c.base05;
      color0 = c.base00;
      color1 = c.base08;
      color2 = c.base0B;
      color3 = c.base0A;
      color4 = c.base0D;
      color5 = c.base0E;
      color6 = c.base0C;
      color7 = c.base05;
      color8 = c.base03;
      color9 = c.base08;
      color10 = c.base0B;
      color11 = c.base0A;
      color12 = c.base0D;
      color13 = c.base0E;
      color14 = c.base0C;
      color15 = c.base06;
    };
  };

  system.stateVersion = "24.05";
}
