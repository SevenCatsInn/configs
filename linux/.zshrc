export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster_custom"
plugins=(git virtualenv zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
export VIRTUAL_ENV_DISABLE_PROMPT=0

. "$HOME/.local/bin/env"

export EDITOR=nvim
export VISUAL=nvim

# Neovim binaries
export PATH="$PATH:/opt/nvim-linux64/bin"
# opencode
export PATH=/home/francesco/.opencode/bin:$PATH
# claude (local)
export PATH=/home/francesco/.claude/local:$PATH
