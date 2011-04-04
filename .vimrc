set enc=utf-8
set fenc=utf-8
set fencs=iso2022-jp,euc-jp,cp-932
set ai
set number
set tabstop=2
set nobackup

"キーバインド
map ,e :NERDTree<CR>
map ,E :NERDTreeToggle<CR>
map ,p :% !perltidy<CR> 
map ,h :!href 
map ,q :q!<CR>
map ,r :QuickRun<CR>
map ,w :w<CR>
map ,z :wq!<CR>
map ,l :split<CR>
map ,k :vsplit<CR>
map ,i :s/^/  /<CR>
map ,I :s/^  //<CR>
map ,g <esc>v%zf
map ,c <Leader>c<Space>
inoremap <C-j> <esc>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
nnoremap ,n :tabedit<Return>
nnoremap ,t :tabnext<Return>
nnoremap ,T :tabprevious<Return>
inoremap <buffer> { {}<LEFT>
inoremap <buffer> ( ()<LEFT>
inoremap <buffer> [ []<LEFT>
inoremap <buffer> < <><LEFT>
inoremap <buffer> " ""<LEFT>
inoremap <buffer> ' ''<LEFT>

set laststatus=2 
set statusline=%n:\ %<%f\ %m%r%h%w[%{&fileformat}][%{has('multi_byte')&&\ &fileencoding!=''?&fileencoding:&encoding}]\ 0x%B=%b%=%l,%c\ %P
set term=builtin_linux
set ttytype=builtin_linux
colorscheme delek
syntax on
set expandtab
set incsearch
set smartindent
set smarttab
set ts=4 sw=2
set softtabstop=2
set expandtab
set comments=""

" ポップアップメニューのカラーを設定
highlight Pmenu ctermbg=lightcyan ctermfg=black 
highlight PmenuSel ctermbg=blue ctermfg=black 
highlight PmenuSbar ctermbg=darkgray 
highlight PmenuThumb ctermbg=lightgray

" scalaのカラーシンタックス
augroup filetypedetect
  au! BufRead,BufNewFile *.scala setfiletype scala
augroup END


" 辞書の指定
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
autocmd FileType scala let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/scala.dict'
let g:AutoComplPop_IgnoreCaseOption = 1

" コンパイラの指定 
autocmd FileType perl compiler perl
autocmd FileType ruby compiler ruby

"<TAB>で補完
function InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col -1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"Rubyのオムニ補完を設定(ft-ruby-omni)
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" NERDTree Option
let NERDTreeShowHidden = 1
let NERDChristmasTree = 1

" QuickRun Option
let g:quickrun_config = {}

" comment plugin
let NERDSpaceDelims = 1
let NERDShutUp=1

" Ruby
autocmd FileType ruby,eruby nnoremap <silent> K :echo expand("<cword>")<CR>
autocmd FileType ruby,eruby inoremap class<Space> class <CR>end<Up><End>
autocmd FileType ruby,eruby inoremap def<Space> def <CR>end<Up><End>
autocmd FileType ruby,eruby inoremap module<Space> module <CR>end<Up><End>


