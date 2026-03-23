# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

. "$HOME/.cargo/env"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Prompt
NAME_HOST_STYLE="\[\e[0;38;2;245;224;220m\]"
WDIR_STYLE="\[\e[0;38;2;137;180;250m\]"
CLEAR_STYLE="\[\e[0m\]"
PS1=""
PS1+="╭─ $NAME_HOST_STYLE\u@\h$CLEAR_STYLE $WDIR_STYLE\w$CLEAR_STYLE\n"
PS1+="╰─ \$ "

