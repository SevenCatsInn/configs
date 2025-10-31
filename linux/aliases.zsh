# Custom Aliases by Francesco Vaccari
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lst='ls -tr1'
alias lll='ls -haotr'

alias naut='nautilus . &'
alias tree2='tree -L 2'
alias tree3='tree -L 3'
alias rdl='readlink -f'
alias vsc="code"
alias temps="watch -n 0.2 sensors"
alias psall="top -c"
alias duu="du -h --max-depth=1"
alias ipython="python -m IPython"
alias tmuxKill="tmux kill-server"
alias tmuxAttach="tmux attach"
alias ipp="ipython --colors linux --no-confirm-exit --no-banner"


# Function to change the tab title
function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

# Change string before the terminal input
# PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\] \W \[\033[00m\]> "

