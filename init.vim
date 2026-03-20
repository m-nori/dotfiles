"vunlde.vimで管理してるpluginを読み込む
source ~/dotfiles2/.vimrc.dein_nvim
"基本設定
source ~/dotfiles2/.vimrc.basic
"StatusLine設定
source ~/dotfiles2/.vimrc.statusline
"インデント設定
source ~/dotfiles2/.vimrc.indent
"表示関連
source ~/dotfiles2/.vimrc.apperance
"補完関連
source ~/dotfiles2/.vimrc.completion
"Tags関連
source ~/dotfiles2/.vimrc.tags
"検索関連
source ~/dotfiles2/.vimrc.search
"移動関連
source ~/dotfiles2/.vimrc.moving
"Color関連
source ~/dotfiles2/.vimrc.colors
"編集関連
source ~/dotfiles2/.vimrc.editing
"エンコーディング関連
source ~/dotfiles2/.vimrc.encoding
"その他
source ~/dotfiles2/.vimrc.misc
"プラグインに依存するアレ
source ~/dotfiles2/.vimrc.plugins_setting

" Plug関連
" call plug#begin('~/.vim/plugged')
call plug#begin('~/.config/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'greggh/claude-code.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.5'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
call plug#end()

" fzf
nnoremap [unite] <Nop>
nmap f [unite]

nnoremap [unite]f :<C-u>Telescope buffers<CR>
nnoremap [unite]b :<C-u>Telescope file_browser<CR>
nnoremap [unite]s :<C-u>Telescope find_files<CR>
nnoremap [unite]g :<C-u>Telescope live_grep<CR>
nnoremap [unite]d :<C-u>Telescope git_status<CR>


"Claude code用
function! SendToClaude(startLine, endLine)
  let lines  =  getline(a:startLine, a:endLine)
  let text  =  join(lines, "\n")
  call system("tmux send-keys -t :.-1 " . shellescape(text))
  call system("tmux send-keys -t :.-1 Enter")
endfunction
" Visualモード：選択範囲送信（:<C-u>で :'<,'> を消す）
vnoremap <leader>r :<C-u>call SendToClaude(line("'<"), line("'>"))<CR>

" Setup for claude-code
lua require('claude-code').setup()

" for NeoVim
if has('nvim')
  set termguicolors
  " set clipboard+=unnamedplus
  set clipboard=unnamed
  set sh=fish
  tnoremap <silent> <ESC> <C-\><C-n>
  map <Leader>t :terminal<CR>
endif

