# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# PROMPT
NAME_HOST_STYLE='%F{#ebe0dc}'
WDIR_STYLE='%F{#89b4fa}'
RESET_FG_COLOR='%f'
NEW_LINE=$'\n'
PROMPT='%B' # bold start
PROMPT+="╭╴ $NAME_HOST_STYLE%n@%m$RESET_FG_COLOR $WDIR_STYLE%~%f$RESET_FG_COLOR$NEW_LINE"
PROMPT+="╰╴ %# "
PROMPT+='%b' # bold end

