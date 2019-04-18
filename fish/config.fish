
if not set -q abbrs_initialized
  set -U abbrs_initialized
  echo -n Setting abbreviations... 

  abbr g 'git'
  abbr ga 'git add'
  abbr gb 'git branch'
  abbr gbl 'git blame'
  abbr gc 'git commit -m'
  abbr gco 'git checkout'
  abbr gcp 'git cherry-pick'
  abbr gd 'git diff'
  abbr gf 'git fetch'
  abbr gl 'git log'
  abbr gm 'git merge'
  abbr gp 'git push'
  abbr gpl 'git pull'
  abbr gr 'git remote'
  abbr gs 'git status'
  abbr gst 'git stash'
 abbr cwtr 'curl https://wttr.in/'
 abbr hc 'herbstclient'
abbr mksh 'cat /home/david/tmp/shell.nix > shell.nix && cat /home/david/tmp/envrc > .envrc'
 alias f 'fff'
  echo 'Done'
end

#fish-nix-shell --info-right | source
set fish_greeting

set PATH ~/scripts $PATH
# direnv hook fish  | source
eval (direnv hook fish)
