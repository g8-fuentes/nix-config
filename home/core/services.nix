{ pkgs, ... }:
{
  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 60480000;
      maxCacheTtl = 60480000;
      extraConfig = "pinentry-program ${pkgs.pinentry-curses}/bin/pinentry-curses";
    };

  };
}
