# Dotfiles

My dotfiles for use on linux with stow

## Install all dotfiles
`stow --verbose --target=${HOME} *`

## Enable services
systemctl --user enable dms.service
systemctl --user enable mailbox-sync-tray.service
systemctl --user enable mailbox-sync.timer
systemctl --user enable mailbox-sync-watcher.service
