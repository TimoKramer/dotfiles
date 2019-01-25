# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath=(/usr/local/share/zsh-completions $fpath)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="material"

# Setup terminal, and turn on colors
#export TERM=xterm-256color
export CLICOLOR=1

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# OH-MY-ZSH
# Path to your oh-my-zsh installation.
#export ZSH=${HOME}/.oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git colored-man github jira virtualenv pip python brew osx tmux zsh-syntax-highlighting)
#plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)

#source $ZSH/oh-my-zsh.sh

# User configuration

autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# http://zshwiki.org/home/zle/bindkeys
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3"   delete-char

# Python
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#export PATH="${HOME}/Library/Python/3.6/bin:$PATH"
#export WORKON_HOME=${HOME}/.virtualenvs
#export PROJECT_HOME=${HOME}/projekte
#source /usr/local/bin/virtualenvwrapper.sh
#
# ANDROID
export ANDROID_HOME=/opt/android-sdk

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias dockerhelp='docker --help | less'
alias ls='ls --color'
alias ll='ls -lahrt'
alias gitlog='git log --graph --pretty=oneline'
alias gits='git status'
alias gitd='git diff'
alias gitl='git log --graph --oneline'
alias gitg='git grep'
alias tmux='tmux -2'
alias pip='pip3'
alias python='python3'
alias updatepac='sudo pacman -Syu'
alias updateaur="yay -Sua --devel --timeupdate"
alias remove-orphans='sudo pacman -Rns $(pacman -Qtdq)'
alias switchuser="light-locker-command -l"
alias peng="ping -c 3 heise.de"
alias clj="clojure"

# opam configuration
test -r /home/timo/.opam/opam-init/init.zsh && . /home/timo/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# graalvm
export PATH="/opt/graalvm/bin:${PATH}"
