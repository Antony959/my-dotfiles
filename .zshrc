export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

export LANG=pt_BR.UTF-8

alias zshcfg="nvim ~/.zshrc"
alias si="sudo pacman -S"
alias syu="sudo pacman -Syu"
alias su="sudo pacman -U"
alias sr="sudo pacman -R"
alias scc="sudo pacman -Scc"
alias Sns="sudo pacman -Rns"
alias ys="yay -S --noconfirm"
alias yr="yay -R"
alias gparted="sudo -EH gparted"
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias grub-update='sudo grub2-mkconfig -o /boot/grub2/grub.cfg'
alias shutdown='shutdown now'
alias hypr="nvim .config/hypr/hyprland.conf"
alias hypr-env="nvim .config/hypr/env.conf"
alias hypr-exec="nvim .config/hypr/exec.conf"
alias hypr-binds="nvim .config/hypr/keybinds.conf"
alias hypr-window="nvim .config/hypr/windowrules.conf"
alias y="yazi"

bindkey "^H" backward-kill-word

fastfetch

export PATH=$PATH:/home/antony/.spicetify

export PATH="$HOME/.local/bin:$PATH"
export TERMINAL=kitty
export EDITOR=nvim

if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

pywal_update() {
    wal -i "$1"
    sh ~/.config/wal/postrun.sh
}
if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

