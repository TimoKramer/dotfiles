# Load vcs_info
autoload -Uz vcs_info

# Set up vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b %m%u%c'
zstyle ':vcs_info:git:*' actionformats '%b|%a %m%u%c'

# Enable checking for staged/unstaged changes
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '+'
zstyle ':vcs_info:git:*' unstagedstr '*'

# Run vcs_info before each prompt
precmd() {
  vcs_info
}

# Set the prompt to include vcs_info
setopt prompt_subst
PROMPT='%F{cyan}%~%f %F{green}${vcs_info_msg_0_}%f $ '
