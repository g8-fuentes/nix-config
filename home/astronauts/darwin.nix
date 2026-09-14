{
  lib,
  pkgs,
  outputs,
  ...
}:
{

  imports = [
    ../planets/common/programs.nix
    ../planets/common/services.nix
    ../planets/common/sops.nix
    ../planets/common/stylix.nix
  ];

  home = {
    username = "administrador";
    homeDirectory = "/Users/administrador";
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
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [ ];
    };
    overlays = [
      (self: super: {
        nodejs = super.nodejs_22;
        nodejs-slim = super.nodejs-slim_22;
      })
    ]
    ++ builtins.attrValues outputs.overlays;

  };

  news.display = "silent";
  targets.darwin.copyApps.enable = true;
  systemd.user.startServices = "sd-switch";

  sops.age.keyFile = lib.mkForce "/Users/administrador/Library/Application Support/sops/age/keys.txt";
}
