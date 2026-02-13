## ALIASES

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias ls='ls --color'
alias ll="eza --all --reverse --sort=modified --long --group-directories-first --header --bytes"
alias lls="eza --all --sort=name --long --group-directories-first --header --bytes"
alias cat='bat'
alias grep='rg --hidden --ignore-case --follow --smart-case'
alias gits='git status'
alias gitc='git commit -S'
alias gitd='git diff'
alias gitl='git log --graph --oneline --pretty="format:%h %G? %aN  %s"'
alias gitg='git grep'
alias gitf='git fetch --all'
alias gita='git add -p'
alias gitp='git push'
alias tmux='tmux -2'
alias pacupdate='sudo pacman -Syu'
alias aurupdate="yay -Sua --devel --timeupdate"
alias pacorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias paccache='sudo pacman -Sc'
alias pacdelrec='sudo pacman -Rcns'
alias packeysupdate='sudo pacman -Sy endeavouros-keyring'
alias wsutilsupdate='wget https://pkg.wslutiliti.es/public.key && pacman-key --add public.key && pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853'
alias switchuser="light-locker-command -l"
alias peng="ping -c 3 heise.de"
alias rbl='clj -Sdeps "{:deps {com.bhauman/rebel-readline {:mvn/version \"LATEST\"}}}" -m rebel-readline.main'
alias repl='clj -m nrepl.cmdline --middleware "[cider.nrepl/cider-middleware]" --interactive'
alias cljserve='clojure -Sdeps "{:deps {nasus {:mvn/version \"LATEST\"}}}" -m http.server'
alias vim='nvim'
alias vimf='nvim $(fzf)'
alias stow='stow --verbose --target=${HOME}'
alias top='btm'
alias find='fd --hidden --no-ignore --follow'
alias jarcontent="jar tf"
alias grep="rg --hidden --follow --no-ignore"
alias docker="podman"
alias work='timer 45m && notify-send --icon="/home/timo/Pictures/Clippy.png" "Work Timer is up! Take a Break 😊" && paplay /usr/share/sounds/freedesktop/stereo/message.oga'
alias rest='timer 5m && notify-send --icon="/home/timo/Pictures/Clippy.png" "Break is over! Get back to work 😬" && paplay /usr/share/sounds/freedesktop/stereo/message.oga'
alias top="dgop"
