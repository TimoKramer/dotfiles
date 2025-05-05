# loading config files
for config_file (${HOME}/.zsh/*.zsh); do
	source $config_file
done

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath=(/usr/local/share/zsh-completions $fpath)

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export EDITOR="nvim"
export BAT_THEME="modus_operandi"

# Autocomplete a slash after ..
zstyle ':completion:*' special-dirs true

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"
#
##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    append_history     #Append history to the history file (no overwriting)
setopt	  hist_ignore_all_dups
unsetopt  hist_ignore_space
setopt    share_history      #Share history across terminals
setopt    inc_append_history  #Immediately append to the history file, not just when a term is killed

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# http://zshwiki.org/home/zle/bindkeys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3"   delete-char

# PATH
export PATH="$PATH:$HOME/.pulumi/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

# GRAALVM
export GRAALVM_HOME="/usr/lib/jvm/java-21-graalvm"

# man
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export GPG_TTY=$TTY
