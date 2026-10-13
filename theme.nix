{ pkgs }:
{
  name = "tokyonight";
  variant = "moon";
  polarity = "dark";
  base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
  monospace = {
    name = "JetBrainsMonoNL Nerd Font";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
}
