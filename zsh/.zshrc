# loading config files
for config_file (${HOME}/.zsh/*.zsh); do
	source $config_file
done

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath=(/usr/local/share/zsh-completions $fpath)

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="material"

# Setup terminal, and turn on colors
export TERM=xterm-256color
export CLICOLOR=1
export EDITOR="nvim"
export BAT_THEME="Coldark-Cold"

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

# User configuration

autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

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
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# GRAALVM
export GRAALVM_HOME="/usr/lib/jvm/java-17-graalvm"

# man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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
alias ls='ls --color'
alias ll="exa --all --reverse --sort=modified --long --group-directories-first --header --bytes"
alias cat='bat'
alias grep='rg --hidden'
alias gits='git status'
alias gitc='git commit -S'
alias gitd='git diff'
alias gitl='git log --graph --oneline --pretty="format:%h %G? %aN  %s"'
alias gitg='git grep'
alias gitf='git fetch --all'
alias gita='git add -p'
alias vim='nvim'
alias tmux='tmux -2'
alias pacupdate='sudo pacman -Syu'
alias aurupdate="yay -Sua --devel --timeupdate"
alias pacorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias paccache='sudo pacman -Sc'
alias pacdeldeps='sudo pacman -Rcns'
alias switchuser="light-locker-command -l"
alias peng="ping -c 3 heise.de"
alias rbl='clj -Sdeps "{:deps {com.bhauman/rebel-readline {:mvn/version \"LATEST\"}}}" -m rebel-readline.main'
alias repl='clj -m nrepl.cmdline --middleware "[cider.nrepl/cider-middleware]" --interactive'
alias cljserve='clojure -Sdeps "{:deps {nasus {:mvn/version \"LATEST\"}}}" -m http.server'
alias vimf='nvim $(fzf)'
alias stow='stow --verbose --target=${HOME}'
alias top='btm'
alias find='fd --hidden --no-ignore'
alias jarcontent="jar tf"

# PROMPT
brname () {
  a=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$a" ]; then
    echo " [$a]"
  else
    echo ""
  fi
}

#export PROMPT="%B%(?..[%?] )%b%n $(brname)> "

export GPG_TTY=$TTY
