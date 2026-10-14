{ lib }:
let
  existing =
    opts:
    lib.concatMapAttrs (
      name: value:
      lib.optionalAttrs (opts ? ${name}) {
        ${name} =
          if builtins.isAttrs value && !(lib.isOption opts.${name}) then
            existing opts.${name} value
          else
            value;
      }
    );

  available =
    pkgs: names:
    let
      path = name: lib.splitString "." name;
      exists =
        name:
        lib.hasAttrByPath (path name) pkgs
        && (builtins.tryEval (lib.getAttrFromPath (path name) pkgs)).success;
      pick = choices: lib.findFirst exists null (lib.toList choices);
    in
    map (name: lib.getAttrFromPath (path name) pkgs) (
      builtins.filter (name: name != null) (map pick names)
    );
in
{
  inherit existing available;
}
