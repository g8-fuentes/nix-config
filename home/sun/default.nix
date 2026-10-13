{ lib, ... }:
{

  imports = [

    ../astronauts/g8.nix

   ../orbits/cli
    ../orbits/dev
    ../orbits/neovim
    ../orbits/terminals/kitty.nix

  ];

}
