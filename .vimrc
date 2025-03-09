" ========================
" Configuration de Vim
" ========================

" Initialisation du gestionnaire de plugins
call plug#begin('~/.vim/plugged')

" Thème plus agréable
Plug 'morhetz/gruvbox'

" Explorateur de fichiers
Plug 'preservim/nerdtree'

" Barre de statut améliorée
Plug 'vim-airline/vim-airline'

" Auto-complétion des paires de parenthèses
Plug 'jiangmiao/auto-pairs'

" Auto-complétion avancée
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ========================
" Apparence et couleurs
" ========================

" Appliquer Gruvbox comme thème par défaut
colorscheme gruvbox

" Activer la vraie gestion des couleurs
set termguicolors
set background=dark

" Activer la coloration syntaxique
syntax on

" ========================
" Interface et confort
" ========================

" Numéros de ligne
set number

" Surligner la ligne actuelle
set cursorline

" Garder une marge autour du curseur lors du défilement
set scrolloff=8

" Activer l'encodage UTF-8
set encoding=utf-8
set fileencoding=utf-8

" ========================
" Autocomplétion et navigation
" ========================

" Améliorer l'autocomplétion des commandes
set wildmenu
set wildmode=longest:full,full
