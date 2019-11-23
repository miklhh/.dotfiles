# Variables.
set -x GDK_SCALE 2.25
set -gx PATH $PATH ~/app_startup/

# Fish PowerLine
function fish_prompt
    if not echo $TERM | egrep "^linux\$"
        /usr/bin/powerline-go -cwd-max-depth 4 -modules venv,user,cwd,perms,gitlite,hg,jobs,exit,root -error $status -shell bare
    else
        echo $eval (pwd)\$\ 
    end
end

# Aliases.
source ~/.config/fish/alias.fish
