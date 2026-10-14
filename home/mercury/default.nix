{ lib, theme, ... }:
{
  imports = [
    ../astronauts/g8.nix
    ../orbits/cli
    ../orbits/neovim
  ];

  home = {
    username = "root";
    homeDirectory = "/root";
  };

  # proot has no user namespaces/seccomp, so the nix sandbox cannot work
  nix.settings = {
    sandbox = false;
    filter-syscalls = false;
  };

  # no systemd in proot
  systemd.user.startServices = lib.mkForce false;
  services.gpg-agent.enable = lib.mkForce false;

  stylix.image = theme.wallpaper "mercury";

  programs.zsh.shellAliases.up = lib.mkForce "nix run home-manager/release-26.05 -- switch --flake ~/nix-config#mercury";
}
