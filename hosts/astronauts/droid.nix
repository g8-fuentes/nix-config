{ lib, pkgs, ... }:
{
  time.timeZone = lib.mkDefault "America/Sao_Paulo";
  user.shell = "${pkgs.zsh}/bin/zsh";
}
