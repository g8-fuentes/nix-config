{ config, lib, pkgs, ... }: {
  programs.qutebrowser = {
    enable = true;
    package = pkgs.qutebrowser;
    aliases = { };
    quickmarks = { st = "https://status.guifuentes8.com.br"; };
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      hm = "https://home-manager-options.extranix.com/?query={}&release=master";
      ns =
        "https://search.nixos.org/packages?channel=24.11&from=0&size=50&sort=relevance&type=packages&query={}";
      nsu =
        "https://search.nixos.org/packages?channel.from=0&size=50&sort=relevance&type=packages&query={}";
      nw = "https://nixos.wiki/index.php?search={}";
      yt = "https://www.youtube.com/results?search_query={}";
    };
    settings = {
      auto_save.session = false;
      colors = {
        tabs = {
          even.bg = lib.mkForce "#${config.lib.stylix.colors.base00}";
          selected.even.bg = lib.mkForce "#${config.lib.stylix.colors.base02}";
          selected.odd.bg = lib.mkForce "#${config.lib.stylix.colors.base02}";
        };
        webpage = {
          darkmode = {
            enabled = false;
            policy.images = "never";
          };
          preferred_color_scheme = "dark";
        };
      };
      content = {
        cookies.accept = "all";
        notifications.enabled = false;
        javascript = {
          enabled = true;
          can_close_tabs = true;
          can_open_tabs_automatically = true;
          clipboard = "access-paste";
        };
      };
      completion = {
        open_categories =
          [ "quickmarks" "searchengines" "bookmarks" "history" ];
      };
      downloads = {
        remove_finished = 5000;
        open_dispatcher = "Thunar";
        location = {
          directory = "${config.home.homeDirectory}/Downloads";
          suggestion = "both";
        };
      };
      scrolling = { smooth = true; };
      statusbar = { show = "in-mode"; };
      tabs = {
        favicons = { scale = 1.2; };
        position = "top";
        last_close = "default-page";
        mousewheel_switching = false;
        show = "multiple";
      };
      url = {
        open_base_url = true;
        start_pages = "https://start.duckduckgo.com";
      };
    };
    extraConfig = ''
      c.tabs.padding = {'top': 4, 'bottom': 4, 'right': 2, 'left': 2}
    '';
  };
}
