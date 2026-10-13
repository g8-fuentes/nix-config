{ pkgs, config, ... }:
{

  imports = [
    ./khal.nix
    ./ncspot.nix
  ];
  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batgrep
        batwatch
      ];
    };
    bottom = {
      enable = true;
      package = pkgs.bottom;
      settings = {
        flags = {
          temperature_type = "c";
          rate = 500;
        };
      };
    };
    feh.enable = true;
    jq.enable = true;
    lsd.enable = true;
    ncmpcpp = {
      package = pkgs.ncmpcpp.override { visualizerSupport = true; };
      enable = false;
    };
    rtorrent.enable = true;
    translate-shell.enable = true;
    yt-dlp.enable = false;
    yazi = {
      enable = true;
      package = pkgs.yazi;
      enableZshIntegration = true;
      keymap = { };
      settings = { };
      theme = { };
    };
  };

  home.packages = with pkgs; [
    clock-rs
    cmatrix
    dipc
    devour
    epr
    girouette
    pastel
    pfetch-rs
    nix-search-cli
    speedtest-rs
    tuifeed
  ];

}
