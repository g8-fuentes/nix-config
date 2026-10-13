{ ... }:
let
  waylandArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

in
{
  imports = [
    ../astronauts/g8.nix
    ../orbits/cli
    ../orbits/neovim
    ../orbits/dev
  ];

  nixpkgs.config = {
    chromium.commandLineArgs = waylandArgs;
    allowUnfree = true;
  };
  targets.genericLinux.enable = true;

  stylix.image = ./jupiter.png;

}
