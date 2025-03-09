#!/bin/bash

set -e  # Stop en cas d'erreur

echo "🚀 Installation de Vim et des plugins..."

# Détecte la distribution Linux
if [ -f /etc/debian_version ]; then
    sudo apt update && sudo apt install -y vim git curl
elif [ -f /etc/arch-release ]; then
    sudo pacman -Sy --noconfirm
else
    echo "⚠️  Distribution non prise en charge. Installe manuellement Vim."
    exit 1
fi

echo "✅ Vim installé avec succès."

# Définir les chemins
VIM_DIR="$HOME/.vim"
VIMRC="$HOME/.vimrc"

# Installer vim-plug si absent
if [ ! -f "$VIM_DIR/autoload/plug.vim" ]; then
    echo "📥 Installation de vim-plug..."
    curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "✅ vim-plug déjà installé."
fi

# Configuration du fichier .vimrc
cat <<EOF > "$VIMRC"
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on
set background=dark
set runtimepath+=~/.vim/plugged/gruvbox

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

nnoremap <C-n> :NERDTreeToggle<CR>
EOF

echo "✅ Fichier .vimrc mis en place."

# 🔄 **Forcer l'installation des plugins avant d'ouvrir Vim**
vim +PlugInstall +qall

echo "colorscheme gruvbox" >> $VIMRC

echo "🎉 Installation terminée ! Ouvre Vim et profite !"
