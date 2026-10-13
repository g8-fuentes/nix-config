{ pkgs, ... }: {
  services.picom = {
    enable = true;
    package = pkgs.picom-allusive;
    extraArgs = [ ];
    backend = "glx";
    vSync = true;
    shadow = false;
    shadowOffsets = [ 1 2 ];
    shadowOpacity = 0.2;
    shadowExclude = [
      "class_g =  'Polybar'"

    ];
    opacityRules = [ ];

    settings = {

      animations = true;
      animation-stiffness = 120;
      animation-window-mass = 0.5;
      animation-dampening = 12;
      animation-clamping = false;
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";

      rounded-corners-exclude = [ "class_g = 'Polybar'" "class_g = 'Rofi'" ];

      shadow-radius = 7;

      fading = true;

      fade-in-step = 3.0e-2;

      fade-out-step = 3.0e-2;

      blur-background = true;
      blur-method = "dual_kawase";
      blur-radius = 4;
      blur-strength = 6;
      blur-whitelist = true;
      blur-rule = [
        "class_g = 'Polybar'"
        "class_g = 'Alacritty'"
        "class_g = 'kitty'"
        "class_g = 'org.wezfurlong.wezterm'"
        "class_g = 'Rofi'"
        "class_g = 'Dunst'"
      ];

      wintypes = {
        utility = {
          shadow = false;
          focus = true;
        };
        popup_menu = {
          shadow = false;
          focus = true;
        };
        dropdown_menu = { shadow = false; };
        menu = { shadow = false; };
      };

    };
  };
}
