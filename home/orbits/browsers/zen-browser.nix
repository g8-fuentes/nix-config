{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.nur.modules.homeManager.default
  ];
  programs.firefox = {
    enable = true;
    package = inputs.zen-browser.packages."${pkgs.system}".default;
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
