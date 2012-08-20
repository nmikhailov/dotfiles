plugins=(archlinux git sprunge tmux vim python yaourt)
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="wezm"
source $ZSH/oh-my-zsh.sh


export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/core_perl
PATH=~/.gem/ruby/1.9.1/bin/:~/.bin/:~/scripts/:$PATH
export EDITOR='vim'
export TERM='screen-256color'
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

alias cd..='cd ..'
alias xclip='xclip -selection clipboard'
alias git-diff='git diff --color'
alias svim='sudo vim'

unsetopt correctall
zstyle ':completion:*:processes' command 'ps xua'
zstyle ':completion:*:processes' sort true
zstyle ':completion:*:processes-names' command 'ps xho command'

bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown

#PROMPT="$FG[248]%T $FX[bold]$FG[110]%n@%m$FX[reset] $FG[248]%. $FX[bold]$FG[111]\$$FX[reset] "
#PROMPT="%{$fg[$ucolor]%}%n%{$reset_color%}%{$reset_color%}:%{$fg[green]%}%0~%{$fg[red]%}%(?.. [%?]) %{$reset_color%}%% "

# TMUX auto start
#if which tmux 2>&1 >/dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
#    test -z "$TMUX" && (tmux attach || tmux new-session)
#    test -z "$TMUX" || tmux new-session
#fi

#bindkey '^i' vi-cmd-mode
#bindkey -M viins 'ESC' vi-cmd-mode

orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo no orphans to remove
    else
        sudo pacman -Rs $(pacman -Qdtq)
    fi
}
