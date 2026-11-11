{ theme, ... }:
{

  imports = [

    ../astronauts/g8.nix

    ../orbits/interfaces/WM/hyprland.nix

    ../orbits/browsers/zen-browser.nix
    ../orbits/browsers/chromium.nix
    ../orbits/terminals/kitty.nix
    ../orbits/cli
    ../orbits/neovim
    ../orbits/programs
    ../orbits/services
    ../orbits/dev

  ];

  wayland.windowManager.hyprland.settings.input = {
    kb_layout = "br";
    kb_variant = "abnt2";
  };

  stylix.image = theme.wallpaper "uranus";
}
