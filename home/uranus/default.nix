{ lib, ... }:
{

  imports = [

    ../astronauts/g8.nix

    ../orbits/interfaces/DE/gnome.nix

    ../orbits/cli
    ../orbits/neovim
    ../orbits/programs
    ../orbits/services
    ../orbits/dev

  ];

  stylix.image = ./uranus.png;
}
