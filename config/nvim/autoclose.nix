{ config, pkgs, ... }:

let
  generateClosingKey = closed:
    {
      escape = false;
      close = true;
      pair = "${closed}";
    };
  generateEscapingKey = closed:
    {
      escape = true;
      close = false;
      pair = "${closed}";
    };
  generateClosingEscapingKey = closed:
    {
      escape = true;
      close = true;
      pair = "${closed}";
    };
in
{
  programs.nixvim.plugins.autoclose = {
    enable = true;
    keys = {
      "(" = generateClosingKey "()";
      "[" = generateClosingKey "[]";
      "{" = generateClosingKey "{}";
      "<" = generateClosingKey "<>" // { enabled_filetypes = [ "markdown" "html" ]; };

      ">" = generateEscapingKey "<>";
      ")" = generateEscapingKey "()";
      "]" = generateEscapingKey "[]";
      "}" = generateEscapingKey "{}";

      "\"" = generateClosingEscapingKey "\"\"";
      "'" = generateClosingEscapingKey "''";
      "`" = generateClosingEscapingKey "``";
    };
    options = {
      autoIndent = true;
      pairSpaces = false;
      touchRegex = "[%w(%[{]";
      disableWhenTouch = false;
      disabledFiletypes = [ "text" ];
    };
  };
}
