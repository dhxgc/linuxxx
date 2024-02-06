
inoremap jk <esc>

  nnoremap <C-c> "+y
  vnoremap <C-c> "+y
  nnoremap <C-p> "+p
  vnoremap <C-p> "+p
  
  " this will install vim-plug if not installed
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
  endif
  
  inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<C-g>u\<TAB>"
  
  :set number
  :set relativenumber
  :set autoindent
  :set tabstop=4
  :set shiftwidth=4
  :set smarttab
  :set softtabstop=4
  :set mouse=a
  
  call plug#begin()
    Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
    Plug 'https://github.com/preservim/nerdtree' " NerdTree
    Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
    Plug 'https://github.com/vim-airline/vim-airline' " Status bar
    Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
    Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
    Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
    Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
    Plug 'https://github.com/terryma/vim-multiple-cursors' " CTRL + N for multiple cursors
    Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
    "Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
    
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
  
    let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed
  
    Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
    
    " these two plugins will add highlighting and indenting to JSX and TSX files.
    Plug 'yuezk/vim-js'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'maxmellon/vim-jsx-pretty'
  call plug#end()
  
  "Для дерева каталогов
    nnoremap <C-f> :NERDTreeFocus<CR>
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
  
  "Для тегбара
    nmap <F8> :TagbarToggle<CR>
  
  "???
    :set completeopt-=preview " For No Previews
    :colorscheme jellybeans
  
  
  let g:NERDTreeDirArrowExpandable="+"
  let g:NERDTreeDirArrowCollapsible="~"
  
  
  
