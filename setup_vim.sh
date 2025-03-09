#!/bin/bash

set -e  # Arrête le script en cas d'erreur

echo "🚀 Installation de Vim et des plugins..."

# Détecte la distribution Linux
if [ -f /etc/debian_version ]; then
    PKG_MANAGER="sudo apt update && sudo apt install -y"
elif [ -f /etc/arch-release ]; then
    PKG_MANAGER="sudo pacman -Sy --noconfirm"
else
    echo "⚠️  Distribution non prise en charge. Installe manuellement Vim."
    exit 1
fi

# Installer Vim et git si absents
if ! command -v vim &> /dev/null; then
    echo "🛠️ Installation de Vim..."
    $PKG_MANAGER vim git curl
else
    echo "✅ Vim déjà installé."
fi

# Chemins des configurations
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

# Installer les plugins Vim avant de générer le fichier .vimrc
echo "📥 Installation des plugins Vim..."
vim +'PlugInstall --sync' +qall
echo "✅ Plugins installés !"

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

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'

call plug#end()

" Vérifier si gruvbox est installé avant d'activer le thème
if filereadable(expand("~/.vim/plugged/gruvbox/colors/gruvbox.vim"))
    colorscheme gruvbox
endif

nnoremap <C-n> :NERDTreeToggle<CR>
EOF

echo "✅ Fichier .vimrc mis en place."
echo "🎉 Installation terminée ! Ouvre Vim et profite !"
