#!/bin/bash

# Define backup directory
backup_dir="$HOME/syncthing/configs/linux/"

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

backup_item() {
    local source=$1
    local dest=$2
    if [ -e "$source" ]; then
        echo "Backing up $source to $dest"
        if [ -d "$source" ] && [ -L "$source" ]; then
            echo "$source is a symlink, skipping backup."
        else
            cp -rf "$source" "$dest"
        fi
    else
        echo "Warning: $source does not exist, skipping..."
    fi
}


# Backup configurations
backup_item "$HOME/.oh-my-zsh/custom/aliases.zsh" "$backup_dir"
backup_item "$HOME/.oh-my-zsh/custom/themes/agnoster_custom.zsh-theme" "$backup_dir"
backup_item "$HOME/.config/nvim/init.lua" "$backup_dir"
backup_item "$HOME/.tmux.conf" "$backup_dir"
backup_item "$HOME/.bashrc" "$backup_dir"
backup_item "$HOME/.zshrc" "$backup_dir"
backup_item "/etc/keyd/default.conf" "$backup_dir"
backup_item "$HOME/.vimrc" "$backup_dir"
backup_item "$HOME/.config/alacritty/alacritty.toml" "$backup_dir"
backup_item "$HOME/.config/kitty/kitty.conf" "$backup_dir"

#
# Backup this script itself
script_path=$(readlink -f "$0")
backup_item "$script_path" "$backup_dir/backup_configs.sh"

echo "Backup completed to $backup_dir"
