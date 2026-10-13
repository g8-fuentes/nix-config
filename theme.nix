{ pkgs }:
{
  name = "rose-pine";
  variant = "moon";
  polarity = "dark";
  base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
  vscode = {
    extension = pkgs.vscode-extensions.mvllow.rose-pine;
    colorTheme = "Rosé Pine Moon";
  };
  monospace = {
    name = "JetBrainsMonoNL Nerd Font";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
}
