{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];
  home.packages = [ pkgs.sops ];
  home.activation.reloadSystemdBeforeSops = lib.mkIf pkgs.stdenv.isLinux (
    lib.hm.dag.entryBetween [ "sops-nix" ] [ "reloadSystemd" ] ''
      # no-op: forces sops-nix to run after linkGeneration and reloadSystemd
    ''
  );

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets/common.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      github-token = { };
    };
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
}
