source $HOME/.installers.sh
[[ "$(chage -l dev | head -1 | cut -d " " -f 4-8)" = "password must be changed" ]] && passwd dev
