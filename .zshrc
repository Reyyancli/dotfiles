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
