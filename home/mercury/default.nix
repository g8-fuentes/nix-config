{ lib, theme, ... }:
{
  imports = [
    ../astronauts/g8.nix
    ../orbits/cli
    ../orbits/neovim
  ];

  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";
    stateVersion = lib.mkForce "24.05";
  };

  stylix.image = theme.wallpaper "mercury";

  programs.zsh.shellAliases.up = lib.mkForce "nix-on-droid switch --flake ~/nix-config#mercury && nh home switch";
}
