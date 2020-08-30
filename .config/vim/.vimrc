" /etc/vimrc

""" Vim-Plug ====================================

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.vim/plugged')      " Minimalist Vim Plugin Manager


""" Settings ====================================

Plug 'tpope/vim-sensible'              " Sensible Defaults

set t_BE=                              " Disable bracketed paste
set nocompatible                       " be iMproved, required
set nobackup                           " .
set noswapfile                         " .
set termencoding=utf-8                 " UTF8 as default encoding
set encoding=utf-8                     " ...
set scrolloff=1000                     " .

if has('gui_running')
	colorscheme slate                  " .
	set guifont=Monospace\ 10          " .
	set background=dark                " .
	set guioptions-=m                  " Remove menu bar
	set guioptions-=T                  " Remove toolbar
	set guioptions-=r                  " Remove right-hand scroll bar
	set guioptions-=L                  " Remove left-hand scroll bar
endif


""" Input =======================================

set mouse=a                            " Enable mouse support
set clipboard=unnamedplus              " Share X11 clipboard
let mapleader = ','                    " .

" Change windows with C-w hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fold Mappings
"set foldmethod=syntax
"set foldnestmax=10
"set nofoldenable
"set foldlevel=0
inoremap <leader>z <C-O>za
nnoremap <leader>z za
onoremap <leader>z <C-C>za
vnoremap <leader>z zf

" Use <leader>/ to clear search highlight
nmap <silent> <leader>/ :nohlsearch<CR>

" Paste Mode
set pastetoggle=<F2>
set listchars=tab:\|.,trail:.,extends:#,nbsp:.


""" Display =====================================

Plug 'vim-airline/vim-airline'         " .
Plug 'vim-airline/vim-airline-themes'  " .
let g:airline#extensions#tabline#enabled = 1

Plug 'edkolev/tmuxline.vim'            " .
let g:tmuxline_powerline_separators = 0


""" Utilities ===================================

Plug 'spolu/dwm.vim'                   " Tiled Window Management
Plug 'tpope/vim-eunuch'                " Helpers for UNIX

Plug 'mileszs/ack.vim'                 " Enhanced Grepping within Vim
if executable('ag')
	let g:ackprg = 'ag --vimgrep --smart-case'
	cnoreabbrev ag Ack
	cnoreabbrev aG Ack
	cnoreabbrev Ag Ack
	cnoreabbrev AG Ack
endif

Plug 'ctrlpvim/ctrlp.vim'              " Fuzzy file/buffer/mru/tag/etc finder
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

Plug 'universal-ctags/ctags'           " ctags implementation
Plug 'majutsushi/tagbar'               " Displays tags in a window
nmap <F8> :TagbarToggle<CR>

Plug 'francoiscabrol/ranger.vim'       " .


""" Languages ===================================

Plug 'sheerun/vim-polyglot'            " Language Support

Plug 'scrooloose/syntastic'            " Syntax checking hacks for vim
nmap <leader>c :SyntasticCheck<CR>
set statusline+=%#warningmsg#
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol="S>"
let g:syntastic_style_error_symbol="E>"
let g:syntastic_warning_symbol="W>"
let g:syntastic_style_warning_symbol="W>"

Plug 'fatih/vim-go'                    " Go support
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck', 'gov']
let g:go_auto_type_info = 1
let g:go_fmt_command = "gofmt"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
au BufWritePost *.go silent! !ctags -R &

Plug 'mxw/vim-jsx'                     " JSX support

Plug 'w0rp/ale'                        " .
let g:ale_linters = {'go': ['gometalinter', 'gofmt', 'govet']}
let g:ale_fixers = {'javascript': ['eslint']}
let g:ale_lint_on_enter = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_list_window_size = 7

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


""" Editor ======================================

set tabstop=4                          " Tabs are 4 columns
set shiftwidth=4                       " ...
set softtabstop=4                      " ...
set expandtab                          " Change tabs to spaces

set list                               " Show whitespace
set number                             " Show line numbers
set wrap linebreak nolist
autocmd BufWritePre * %s/\s\+$//e      " Delete trailing whitespace on save

Plug 'tpope/vim-sleuth'                " Heuristically set buffer options
Plug 'nathanaelkane/vim-indent-guides' " Visaully display indent level

Plug 'junegunn/vim-easy-align'         " Easier text alignment
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

Plug 'ervandew/supertab'               " Vim insert mode completions with Tab
let g:SuperTabDefaultCompletionType = "context"

Plug 'tpope/vim-surround'              " Quoting/Parenthesizing made simple
Plug 'junegunn/limelight.vim'          " Hyperfocus-writing in Vim


""" Version Control System ======================

Plug 'airblade/vim-gitgutter'          " Show git diff in the gutter
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk

call plug#end()