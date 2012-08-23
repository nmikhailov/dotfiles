plugins=(archlinux git sprunge tmux vim python yaourt)
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wezm"
source $ZSH/oh-my-zsh.sh


export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl
PATH=~/.gem/ruby/1.9.1/bin/:~/.bin/:~/Scripts/:$PATH
export EDITOR='vim'
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

alias cd..='cd ..'
alias xclip='xclip -selection clipboard'
alias git-diff='git diff --color'
alias svim='sudo vim'
alias systemctl='sudo systemctl'

unsetopt correctall
zstyle ':completion:*:processes' command 'ps xua'
zstyle ':completion:*:processes' sort true
zstyle ':completion:*:processes-names' command 'ps xho command'

bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown

orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo no orphans to remove
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
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
[ -n "$TMUX" ] && export TERM='screen-256color'
set -o vi
