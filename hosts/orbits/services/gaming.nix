{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    (lutris.override {
      extraLibraries = pkgs:
        [
        ];
    })
    pokemmo-installer
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true;
    dedicatedServer.openFirewall =
      true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

}
