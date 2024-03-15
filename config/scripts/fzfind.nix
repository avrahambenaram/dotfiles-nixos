{ pkgs }:

pkgs.writeShellScriptBin "fzfind" ''
file=$(${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat --style=numbers --color=always {}' --preview-window=up:60%:wrap)
[ -n "$file" ] && nvim -c "cd $(dirname "$file")" "$file"
''
