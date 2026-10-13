{ pkgs, ... }: {

  imports = [ ./common ];
  programs.hyprland.enable = true;

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = (with pkgs; [ xdg-utils ]);

    etc."greetd/environments".text = ''
      Hyprland  
    '';
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
  };

}
