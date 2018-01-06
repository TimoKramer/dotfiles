export EDITOR=vim

# color for bash
export CLICOLOR=1

# Python
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#export PATH="/Users/timokramer/Library/Python/3.6/bin:$PATH"
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/projekte
#source /usr/local/bin/virtualenvwrapper.sh

alias dockerhelp='docker --help | less'
alias ll='ls -lah'
alias gitnocert='git -c http.sslVerify=false'
alias gitlog='git log --graph'
#alias tmux='tmux -2'
source /home/timo/.tmc-autocomplete.sh
