{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_20
    pnpm
    yarn
  ];
  programs.zsh.initExtra = ''
  #pnpm
  export PNPM_HOME="${config.home.homeDirectory}/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  # pnpm end
  '';
}
