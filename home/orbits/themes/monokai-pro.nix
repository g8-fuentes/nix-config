{ lib, pkgs, ... }: {

  stylix.base16Scheme =
    lib.mkForce "${pkgs.base16-schemes}/share/themes/monokai.yaml";
  stylix.override = {
    base00 = "2d2a2e";
    base01 = "383438";
    base02 = "4f4a4f";
    base03 = "686366";
    base04 = "e1e1e3";
    base05 = "f8f8f2";
    base06 = "f9f9f5";
    base07 = "ffffff";
    base08 = "ff6188";
    base09 = "fc9867";
    base0A = "ffd866";
    base0B = "a9dc76";
    base0C = "78dce8";
    base0D = "ab9df2";
    base0E = "f975e6";
    base0F = "f8f8f0";
  };
}
