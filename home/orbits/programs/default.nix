{ pkgs, ... }:
{

  imports = [
    ./vscode.nix
    ./xdg.nix
  ];
  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-shaderfilter
        wlrobs
      ];
    };
  };
  home.packages = with pkgs; [
    discord
    evolution
    flameshot
    figma-linux
    figma-agent
    fontpreview
    gimp
    onlyoffice-desktopeditors
    pavucontrol

  ];

}
