{
  config,
  pkgs,
  lib,
  options,
  ...
}:
{
  imports = [ ];

  config = lib.optionalAttrs (options ? sops) {
    home.packages = [ pkgs.sops ];
    home.activation.reloadSystemdBeforeSops = lib.mkIf pkgs.stdenv.isLinux (
      lib.hm.dag.entryBetween [ "sops-nix" ] [ "reloadSystemd" ] ''
      ''
    );

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = ../../secrets/common.yaml;
      defaultSopsFormat = "yaml";
      secrets = {
        github-token = { };
      };
    };
    systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  };
}
