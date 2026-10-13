{ ... }:
{

  imports = [ ./tty.nix ];

  boot.kernelParams = [ "console=tty1" ];
  security.pam.services.greetd.enableGnomeKeyring = true;

  services.greetd = {
    enable = true;
    settings = { };
  };

}
