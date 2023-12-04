# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/fzf/key-bindings.zsh"

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
