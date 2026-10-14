{ theme, ... }:
{

  imports = [

    ../astronauts/g8.nix

    ../orbits/interfaces/DE/kde.nix

    ../orbits/cli
    ../orbits/neovim
    ../orbits/programs
    ../orbits/services
    ../orbits/dev

  ];

  stylix.image = theme.wallpaper "neptune";
}
