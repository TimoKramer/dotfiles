# Setup fzf
# ---------
if [[ ! "$PATH" == */home/timo/.fzf/bin* ]]; then
  export PATH="$PATH:/home/timo/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/timo/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/timo/.fzf/shell/key-bindings.zsh"

