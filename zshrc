plugins=(archlinux git sprunge tmux vim python yaourt vi-mode)
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wezm"
source $ZSH/oh-my-zsh.sh

# Custom RPROMPT
RPROMPT='%{$fg[green]%}%~ %{$fg[blue]%}@%m%{$reset_color%}'

export XDG_CONFIG_HOME=~/.config/
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl:$PATH
PATH=/usr/bin/vendor_perl:~/.gem/ruby/1.9.1/bin/:~/.bin/:~/Scripts/:$PATH
PATH=~/Programming/olymp/codejam/2013/cli/:$PATH
PATH=/opt/android-sdk/tools/:$PATH
export EDITOR='vim'
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#export _JAVA_OPTIONS="-Dswing.useSystemAASettings=lcd_hrgb -Dswing.aatext=true -D.sw -Dsun.java2d.xrender=true"
#export _JAVA_OPTIONS="-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.useSystemAASettings=lcd_hrgb -Dswing.aatext=true -D.sw -Dsun.java2d.xrender=true"
export _JAVA_OPTIONS="-Dswing.aatext=true -Dawt.useSystemAAFontSettings=gasp"
export BROWSER='firefox'
export $(dbus-launch)

alias cd..='cd ..'
alias xclip='xclip -selection clipboard'
alias svim='sudo vim'
#alias systemctl='sudo systemctl'
alias ssh-term="TERM=linux ssh"
alias l='ls -la'

# Directory aliases
hash -d study=~/Study/s08/
hash -d repos=~/Repositories/
hash -d nfs=/media/nfs


unsetopt correctall
zstyle ':completion:*:processes' command 'ps xua'
zstyle ':completion:*:processes' sort true
zstyle ':completion:*:processes-names' command 'ps xho command'

# Alt-S insert_sudo
insert_sudo () {
    zle beginning-of-line;
    zle -U "sudo "
}
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

# Orphaned packages

orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo no orphans to remove
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
}

mkcd() {
    mkdir -p $1 && cd $1
}

cdtmp() {
    cd $(mktemp -d)
}

# colour coreutils
eval $(dircolors -b ~/.dir_colors)
alias grep='grep --color=always'
export GREP_COLOR="1;33"

## linux console colors (jwr dark) ###

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P83d3d3d" #darkgrey
    echo -en "\e]P18c4665" #darkred
    echo -en "\e]P9bf4d80" #red
    echo -en "\e]P2287373" #darkgreen
    echo -en "\e]PA53a6a6" #green
    echo -en "\e]P3914e89" #brown
    echo -en "\e]PBbf85cc" #yellow
    echo -en "\e]P4395573" #darkblue
    echo -en "\e]PC477ab3" #blue
    echo -en "\e]P55e468c" #darkmagenta
    echo -en "\e]PD7e62b3" #magenta
    echo -en "\e]P631658c" #darkcyan
    echo -en "\e]PE6096bf" #cyan
    echo -en "\e]P7899ca1" #lightgrey
    echo -en "\e]PFc0c0c0" #white
    clear # bring us back to default input colours
fi
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for guake
bindkey "\eOF" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\e[3~" delete-char # Del

[ -n "$TMUX" ] && export TERM='screen-256color'
#PS1+='$(vi_mode_prompt_info)'
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^r' history-incremental-pattern-search-backward
