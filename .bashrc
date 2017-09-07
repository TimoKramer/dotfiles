
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export EDITOR=vim

# color for bash
export CLICOLOR=1

# GOLANG
export GOPATH="${HOME}/go"

alias dockerhelp='docker --help | less'
alias ll='ls -lah'
alias gitnocert='git -c http.sslVerify=false'
alias gitlog='git log --graph'
alias tmux='tmux -2'
alias livesshtun='ssh -L 8080:lpuppmv001.unix.live.local:80 -Nf lpuppmv001.unix.live.local'
