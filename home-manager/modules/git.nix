{ config, pkgs, libs, ... }:

let
  git-clean = pkgs.writeShellScriptBin "git-clean" ''
    #!${pkgs.bash}/bin/bash
    set -euo pipefail
    LINES="${LINES:-40}"

    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
      echo "Not inside a Git repository." >&2
      exit 1
    }

    # Grab untracked paths from "git status --short"
    git status --short --untracked-files=all | \
    awk '$1=="??"{sub(/^.. /,""); print}' | \
    while IFS= read -r path; do
      [[ -e "$path" ]] || continue
      [[ -d "$path" ]] && continue   # skip directories

      echo "=============================================="
      echo "File: $path"
      echo "----------------------------------------------"
      ${pkgs.bat}/bin/bat --style=plain --pager=never --line-range ":$LINES" -- "$path" || true
      echo "----------------------------------------------"
      echo "[k]eep, [d]elete?"

      read -r -n 1 choice < /dev/tty || choice="k"
      echo ""

      case "$choice" in
        d|D) rm -- "$path" && echo "Deleted $path" || echo "Kept $path" ;;
        *)   echo "Kept $path" ;;
      esac
    done
  '';
in {
  home.packages = with pkgs; [
    git
    git-lfs
    gitAndTools.delta
    gitAndTools.gh
    gitAndTools.git-crypt
    pre-commit
    git-clean
  ];
  home.file.".config/git/ignore".text = ''
    tags
    result
    .DS_Store
    *.swp
    *.swo
  '';
  home.file.".config/git/config".source = ../configs/git/gitconfig;
}
