set nocompatible        " Must be first line

let g:cary_plugin_groups = [
      \   'general',
      \   'markdown',
      \   'javascript'
      \ ]

let g:coc_global_extensions = [
      \   'coc-cssmodules',
      \   'coc-emmet',
      \   'coc-eslint',
      \   'coc-git',
      \   'coc-json',
      \   'coc-lists',
      \   'coc-stylelintplus',
      \   'coc-terminal',
      \   'coc-tsserver',
      \   'coc-yank'
      \ ]

call plug#begin('~/.vim/plugged')

if count(g:cary_plugin_groups, 'general')
  Plug 'vim-airline/vim-airline'
  Plug 'preservim/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'tpope/vim-commentary'
  Plug 'psliwka/vim-smoothie'
endif

if count(g:cary_plugin_groups, 'javascript')
  Plug 'leafgarland/typescript-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'peitalin/vim-jsx-typescript'
endif


call plug#end()

filetype plugin indent on   " Automatically detect file types.
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

set clipboard=unnamed

set suffixesadd=.ts,.js,.tsx,.jsx,.json   "gf extensions

set foldmethod=indent
set nofoldenable
set foldlevel=99
set history=1000                    " Store a ton of history (default is 20)
set nospell                         " Spell checking off
set hidden                          " Allow buffer switching without saving

" Vim UI

set guifont=MonoLisa-Black:h15

set guioptions-=r               " remove right-hand scroll bar
set guioptions-=l               " remove left-hand scroll bar
set guioptions-=L               " remove left-hand scroll bar even if there is a vertical split
set guioptions-=b               " remove bottom scroll bar

set scrolloff=3                 " scroll when 3 line
set cursorline                  " Highlight current line
set number                      " Line numbers on
set ignorecase                  " Case insensitive search

" Formatting 
set wrap                        " Do wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every 2 columns
set softtabstop=2               " Let backspace delete indent
set splitright                  " Puts new vsplit windows to the right of the current


let mapleader = ' '
let maplocalleader = ','

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Plugins
" Coc.nvim {
if isdirectory(expand("~/.vim/plugged/coc.nvim"))
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " using `<TAB>`
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <C-d>, <cr> to confirm completion
  inoremap <silent><expr> <C-d> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " coc-prettier
  " Formatting selected code.
  vmap <leader>fp  <Plug>(coc-format-selected)

  " Apply AutoFix to problem on the current line.
  nmap <leader>fq  <Plug>(coc-fix-current)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>fs <Plug>(coc-codeaction-line)
  nmap <leader>fa <Plug>(coc-codeaction)

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Function refactor.
  nmap <leader>rf <Plug>(coc-refactor)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gj <Plug>(coc-float-jump)
  " use <C-\><C-n> exit terminal mode
  tnoremap <Esc> <C-\><C-n>
  nmap <silent> gt <Plug>(coc-terminal-toggle)

  " navigate diagnostics
  nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
  nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nmap <silent> [d <Plug>(coc-diagnostic-prev)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Use CTRL-S for selections ranges.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

  " Using CocList
  " Resume latest coc list
  nnoremap <silent> <localleader>p  :<C-u>CocListResume<CR>

  " Keymapping for grep word under cursor with interactive mode
  nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

  nnoremap <silent> <Leader>w :exe 'CocList -I --input='.expand('<cword>').' words'<CR>
  nnoremap <silent> * :exe 'CocList -I --input='.expand('<cword>').' words'<CR>

  nnoremap <silent><nowait> <Leader>ln :<C-u>CocNext<cr>
  nnoremap <silent><nowait> <Leader>lp :<C-u>CocPrev<cr>
  nnoremap <silent><nowait> <Leader>ll :<C-u>CocList<cr>
  nnoremap <silent><nowait> / :<C-u>CocList lines<cr>
  nnoremap <silent><nowait> <Leader>lb :<C-u>CocList buffers<cr>
  nnoremap <silent><nowait> <Leader>lm :<C-u>CocList mru<cr>
  nnoremap <silent><nowait> <Leader>lf :<C-u>CocList files<cr>
  nnoremap <silent><nowait> <Leader>lg :<C-u>CocList grep<cr>
  nnoremap <silent><nowait> <Leader>lc :<C-u>CocList commands<cr>
  nnoremap <silent><nowait> <Leader>ld :<C-u>CocList diagnostics<cr>
  nnoremap <silent><nowait> <Leader>lo :<C-u>CocList outline<cr>
  nnoremap <silent><nowait> <Leader>le :<C-u>CocList extensions<cr>
  nnoremap <silent><nowait> <Leader>ls :<C-u>CocList symbols<cr>
  nnoremap <silent><nowait> <Leader>lw :<C-u>CocList words<cr>

  " Using coc-git
  " navigate chunks of current buffer
  nmap [g <Plug>(coc-git-prevchunk)
  nmap ]g <Plug>(coc-git-nextchunk)
  " navigate conflicts of current buffer
  nmap [c <Plug>(coc-git-prevconflict)
  nmap ]c <Plug>(coc-git-nextconflict)
  " show chunk diff at current position
  nmap gs <Plug>(coc-git-chunkinfo)
  " show commit contains current position
  nmap gc <Plug>(coc-git-commit)
  " create text object for git chunks
  omap ig <Plug>(coc-git-chunk-inner)
  xmap ig <Plug>(coc-git-chunk-inner)
  omap ag <Plug>(coc-git-chunk-outer)
  xmap ag <Plug>(coc-git-chunk-outer)
  nnoremap <silent> <Leader>gs :<C-u>CocList gstatus<CR>

  " Using coc-smartf
  " press <esc> to cancel.
  nmap s <Plug>(coc-smartf-forward)
  nmap S <Plug>(coc-smartf-backward)

  augroup Smartf
    " :highlight Conceal show default Conceal color
    autocmd User SmartfEnter :hi Conceal ctermfg=1 guifg=#BF616A
    autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=Grey30
  augroup end

  " Using coc-highlight
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" Airline {
if isdirectory(expand("~/.vim/plugged/vim-airline"))
  let g:airline_powerline_fonts = 0
  let g:airline#extensions#tmuxline#enabled = 0
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#hunks#coc_git = 1
  let g:airline_section_x = ''
  let g:airline_section_y = airline#section#create_right(['filetype'])
endif

"file explor like vscode ctrl+p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

"comment & uncomment mutiple lines
noremap <leader>/ :Commentary<cr>
