callback:

let
  keys = {
    "$left" = "l";
    "$right" = "r";
    "$up" = "u";
    "$down" = "d";
  };
  keysAttrs = builtins.attrNames keys;
in
builtins.map (key: callback key keys.${key}) keysAttrs
