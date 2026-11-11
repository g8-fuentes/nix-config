{ ... }: {
  imports = [
    ../../browsers/zen-browser.nix
    ../../browsers/chromium.nix
    ../../cli
    ../../programs
    ../../services
    ../../terminals/ghostty.nix
    ../../neovim
  ];

}
