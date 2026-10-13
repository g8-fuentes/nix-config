{ ... }:

{
  imports = [
    ./dunst.nix
    ./mpv.nix
    ./rofi
  ];

  programs = {
    zathura.enable = true;
  };
}
