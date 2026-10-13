{ pkgs, ... }:

{

  programs = {
  };

  home.packages = with pkgs; [
    nodejs_22
    unstable.pnpm_10
    nixfmt
  ];
}
