{ pkgs }:

let
  fzfBin = "${pkgs.fzf}/bin/fzf";
  batBin = "${pkgs.bat}/bin/bat";
in 
pkgs.writeShellScriptBin "fzfindt" ''
# Check if tmux is running
if [ -n "$TMUX" ]; then
  # tmux is running, open file in Vim directly
  file=$(${fzfBin} --preview '${batBin} --style=numbers --color=always {}' --preview-window=up:60%:wrap)
  [ -n "$file" ] && nvim -c "cd $(dirname "$file")" "$file"
else
  # tmux is not running, start a new Tmux session and open file in Vim
  file=$(${fzfBin} --preview '${batBin} --style=numbers --color=always {}' --preview-window=up:60%:wrap)
  [ -n "$file" ] && tmux new-session -d "nvim -c 'cd $(dirname "$file")' '$file'" && tmux attach
fi
''
