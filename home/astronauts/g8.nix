# ####
# DEFAULT CONFIG USER (Home-Manager)
#####

{
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{

  imports = [
    ../planets/common/dependencies.nix
    ../planets/common/programs.nix
    ../planets/common/services.nix
    ../planets/common/stylix.nix
    ../planets/common/sops.nix
  ];

  home = {
    username = "g8-fuentes";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "26.11";
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  fonts.fontconfig.enable = true;
  news.display = "silent";
  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Music";
      videos = "${config.home.homeDirectory}/Videos";
      pictures = "${config.home.homeDirectory}/Pictures";
      download = "${config.home.homeDirectory}/Downloads";
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      extraConfig = {
        fonts = "${config.home.homeDirectory}/.local/share/fonts";
      };
    };
  };

}
