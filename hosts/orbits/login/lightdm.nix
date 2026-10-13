{ ... }: {
  security.pam.services.lightdm.enableGnomeKeyring = true;
  services.xserver = {
    enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        greeters = {
          gtk = {
            enable = true;
            indicators = [
              "~host"
              "~spacer"
              "~clock"
              "~spacer"
              "~session"
              "~language"
              "~a11y"
              "~power"
            ];
            extraConfig = "";
          };
        };
      };
    };
  };
}
