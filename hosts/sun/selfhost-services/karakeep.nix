{ pkgs, lib, ... }: {
  services.karakeep = {
    enable = true;
    meilisearch.enable = false;
    browser = { enable = false; };
    extraEnvironment = {
      PORT = "9109";
      DISABLE_SIGNUPS = "true";
      DISABLE_NEW_RELEASE_CHECK = "true";
    };

  };
}
