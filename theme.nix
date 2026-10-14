{ pkgs }:
let
  base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
in
{
  name = "kanagawa";
  variant = "wave";
  polarity = "dark";
  inherit base16Scheme;
  vscode = {
    extension = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
      mktplcRef = {
        publisher = "qufiwefefwoyn";
        name = "kanagawa";
        version = "1.5.1";
        hash = "sha256-AGGioXcK/fjPaFaWk2jqLxovUNR59gwpotcSpGNbj1c=";
      };
    };
    colorTheme = "Kanagawa";
  };
  monospace = {
    name = "JetBrainsMonoNL Nerd Font";
    package = pkgs.nerd-fonts.jetbrains-mono or (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
  };
  colors = builtins.listToAttrs (
    map
      (
        line:
        let
          m = builtins.match " *(base0[0-9A-F]): *\"#?([0-9a-fA-F]{6})\".*" line;
        in
        {
          name = builtins.elemAt m 0;
          value = "#" + pkgs.lib.toLower (builtins.elemAt m 1);
        }
      )
      (
        builtins.filter (line: builtins.match " *base0[0-9A-F]: *\"#?[0-9a-fA-F]{6}\".*" line != null) (
          pkgs.lib.splitString "\n" (builtins.readFile base16Scheme)
        )
      )
  );
  wallpaper =
    name:
    pkgs.runCommand "wallpaper-${name}.png" { nativeBuildInputs = [ pkgs.lutgen ]; } ''
      colors=$(sed -nE 's/^ *base0[0-9A-F]: *"#?([0-9a-fA-F]{6})".*/#\1/p' ${base16Scheme})
      lutgen apply -o $out ${./wallpapers + "/${name}.png"} -- $colors
    '';
}
