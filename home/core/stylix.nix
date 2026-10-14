{
  pkgs,
  lib,
  config,
  options,
  outputs,
  ...
}:
let
  theme = import ../../theme.nix { inherit pkgs; };
in
{
  _module.args.theme = theme;

  stylix = {
    enable = true;
    autoEnable = true;
    polarity = theme.polarity;
    base16Scheme = theme.base16Scheme;
    imageScalingMode = "fill";
    fonts.monospace = theme.monospace;
    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
    };
    targets = outputs.lib.existing options.stylix.targets {
      alacritty.enable = true;
      bat.enable = true;
      btop.enable = true;
      dunst.enable = true;
      feh.enable = true;
      firefox.enable = true;
      firefox.profileNames = [ "${config.home.username}" ];
      fish.enable = false;
      foot.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      gitui.enable = true;
      gnome.enable = lib.mkIf (pkgs.stdenv.hostPlatform.isLinux) true;
      gtk.enable = true;
      hyprland.enable = true;
      hyprland.hyprpaper.enable = true;
      hyprlock.enable = true;
      hyprpaper.enable = true;
      i3.enable = true;
      kde.enable = true;
      kitty.enable = true;
      mako.enable = true;
      mpv.enable = true;
      ncspot.enable = true;
      nixvim.enable = false;
      qutebrowser.enable = true;
      rofi.enable = true;
      starship.enable = true;
      sway.enable = true;
      swaylock.enable = true;
      tmux.enable = true;
      vim.enable = true;
      vscode.enable = false;
      waybar.enable = false;
      wezterm.enable = true;
      wpaperd.enable = true;
      xfce.enable = false;
      yazi.enable = true;
      zathura.enable = true;
    };
  };

  home.activation.setDarwinWallpaper =
    lib.mkIf (pkgs.stdenv.hostPlatform.isDarwin && config.stylix.image != null)
      (
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run /usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "${config.stylix.image}"'
        ''
      );

  gtk = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
  };
}
