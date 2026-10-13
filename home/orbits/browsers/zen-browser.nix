{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.nur.modules.homeManager.default
    inputs.zen-browser.homeModules.default
  ];
  stylix.targets.zen-browser.profileNames = [ config.home.username ];

  programs.zen-browser = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
    };
    profiles."${config.home.username}" = {
      isDefault = true;
      id = 0;
      name = "${config.home.username}";
      settings = {
        "extensions.autoDisableScopes" = 0;
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        floccus
        react-devtools
        reduxdevtools
        stylus
        ublock-origin
      ];
    };
  };

}
