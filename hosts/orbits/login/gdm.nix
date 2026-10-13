{ outputs, pkgs, ... }:

{
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  services = { displayManager.gdm.enable = true; };
}
