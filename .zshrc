## Plugins

# autosuggestions
source ~/git\ repos/zsh-autosuggestions/zsh-autosuggestions.zsh

# autocomplete
source ~/git\ repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh

bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete

# Manjaro configured
source ~/git\ repos/manjaro-zsh-config/manjaro-zsh-config



# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

# starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

alias n="nvim"
export PATH=/home/reyyan/.local/bin:/home/reyyan/.local/share/appimages:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/reyyan/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

export PATH=$PATH:/home/reyyan/.spicetify
export LIBVIRT_DEFAULT_URI="qemu:///system"

# bun completions
[ -s "/home/reyyan/.bun/_bun" ] && source "/home/reyyan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export SUDO_PROMPT=" $(tput setaf 15)$(tput sgr0)$(tput setab 15 setaf 0 bold)Sudo$(tput sgr0)$(tput setaf 15)$(tput sgr0) Enter password for $(tput setaf 6)%p$(tput sgr0): "

if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
