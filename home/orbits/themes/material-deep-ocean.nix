{ lib, pkgs, ... }: {

  stylix.base16Scheme =
    lib.mkForce "${pkgs.base16-schemes}/share/themes/material.yaml";
  stylix.override = { base00 = "0F111A"; };
}
