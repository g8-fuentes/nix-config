{
  pkgs,
  config,
  lib,
  ...
}:

{

  home.packages = [
    pkgs.age
  ]
  ++ lib.optional pkgs.stdenv.isLinux pkgs.nextcloud-client;

  programs = {

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings.git_protocol = "https";
      extensions = [ pkgs.gh-eco ];
    };

    gh-dash.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        http.postBuffer = "524288000";
        pull.rebase = false;
        push.autoSetupRemote = true;
        init.defaultBranch = "main";
        user = {
          name = "Guilherme Fuentes";
          email = "guifuentes8@gmail.com";
        };
        alias = {
          a = "add .";
          ch = "checkout";
          new = "checkout -b";
          cm = "commit -m";
          ps = "push";
          pl = "pull";
          fe = "fetch";
          st = "status";
          rs = "reset HEAD~1 --hard";
        };
      };
    };
    gpg.enable = true;

    home-manager.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      flake = "${config.home.homeDirectory}/nix-config";
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initContent = ''
        unset -v SSH_ASKPASS
        export GITHUB_TOKEN=$(cat ${config.sops.secrets.github-token.path})
      '';
      shellAliases = {
        cjpg = "mogrify -format jpg *.png && rm *.png";
        pick = "xcolor | hyprpicker";
        clock = "clock-rs";
        matrix = "cmatrix -b -f -C red";
        climabauru = "girouette -q -c '1h' -L 'pt_BR' -l 'Bauru' -u metric";
        climasp = "girouette -q -c '1h' -L 'pt_BR' -l 'São Paulo' -u metric";
        torrent = "rtorrent";
        feed = "tuifeed";
        mail = "himalaya -a guifuentes8";
        mail2 = "himalaya -a gcf";

        rotate = "echo 0 | sudo tee /sys/class/graphics/fbcon/rotate_all";
        rotate1 = "echo 1 | sudo tee /sys/class/graphics/fbcon/rotate_all";
        rotate2 = "echo 2 | sudo tee /sys/class/graphics/fbcon/rotate_all";
        rotate3 = "echo 3 | sudo tee /sys/class/graphics/fbcon/rotate_all";
        rotate4 = "echo 4 | sudo tee /sys/class/graphics/fbcon/rotate_all";

        testnet = "speedtest-rs";
        music = "ncmpcpp";

        up = "${if pkgs.stdenv.hostPlatform.isDarwin then "nh darwin switch" else "nh os switch"} && nh home switch";
      };
    };
  };

}
