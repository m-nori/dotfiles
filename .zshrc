#-----------------------------------------------------------------
# 基本設定
#-----------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000

#-----------------------------------------------------------------
# 環境変数
#-----------------------------------------------------------------
# set path
PATH=/usr/local/bin:${PATH}:${HOME}/Tools
PATH=$HOME/.nodebrew/current/bin:$PATH:~/Library/Python/2.7/bin
export PATH

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

#-----------------------------------------------------------------
# プロンプト
#-----------------------------------------------------------------
# プロンプトのカラー表示を有効
autoload -U colors
colors
usernam=`whoami`
setopt prompt_subst
. ~/dotfiles/prompt.zsh
source ~/dotfiles/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# powerline-daemon -q
# . ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

#-----------------------------------------------------------------
# シェル変数設定
#-----------------------------------------------------------------
#
# シェルの基本的な動作を変更するスイッチは、ほぼシステム非依存。
setopt  always_last_prompt      # 無駄なスクロールを避ける
setopt  auto_list                       # 自動的に候補一覧を表示
setopt  auto_menu                       # 自動的にメニュー補完する
setopt  auto_cd
#setopt auto_name_dirs          # "~$var" でディレクトリにアクセス
#setopt  auto_param_keys         # 変数名を補完する
#setopt  auto_remove_slash       # 接尾辞を削除する
#setopt  bang_hist                       # csh スタイルのヒストリ置換
#setopt  brace_ccl                       # {a-za-z} をブレース展開
#setopt  cdable_vars                     # 先頭に "~" を付けたもので展開
setopt  complete_in_word        # 語の途中でもカーソル位置で補完
#setopt  complete_aliases        # 補完動作の解釈前にエイリアス展開
#setopt  extended_glob           # "#", "~", "^" を正規表現として扱う
#setopt  extended_history        # 開始/終了タイムスタンプを書き込み
#setopt hist_verify                     # ヒストリ置換を実行前に表示
#setopt glob_dots                       # "*" にドットファイルをマッチ
#setopt  hist_ignore_dups        # 直前のヒストリと全く同じとき無視
#setopt  hist_ignore_space       # 先頭がスペースで始まるとき無視
#setopt  list_types                      # ファイル種別を表す記号を末尾に表示
setopt  magic_equal_subst       # "val=expr" でファイル名展開
#setopt menu_complete           # 一覧表示せずに、すぐに最初の候補を補完
setopt  multios                         # 複数のリダイレクトやパイプに対応
setopt  numeric_glob_sort       # ファイル名を数値的にソート
setopt  noclobber                       # リダイレクトで上書き禁止
setopt no_beep                         # ベルを鳴らさない
#setopt no_check_jobs           # シェル終了時にジョブをチェックしない
#setopt  no_flow_control         # C-s/C-q によるフロー制御をしない
#setopt  no_hup                          # 走行中のジョブにシグナルを送らない
setopt  no_list_beep            # 補完の時にベルを鳴らさない
#setopt  notify                          # ジョブの状態をただちに知らせる
setopt  pushd_ignore_dups       # 重複するディレクトリを無視
#setopt  rm_star_silent          # "rm * " を実行する前に確認
#setopt  sun_keyboard_hack       # 行末の "` (バッククウォート)" を無視
#setopt  sh_word_split           # 変数内の文字列分解のデリミタ
setopt  histallowclobber        # ">" を ">!" としてヒストリ保存
setopt  printeightbit           # 8ビットクリーン表示→うまく動作せず
setopt auto_cd                  # 第1引数がディレクトリだと cd を補完
setopt list_packed              # 補完候補リストを詰めて表示
setopt print_eight_bit          # 補完候補リストの日本語を適正表示
setopt AUTO_PUSHD               #cdの履歴を登録
setopt PUSHD_IGNORE_DUPS        #重複するディレクトリを削除
setopt append_history           # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt hist_ignore_dups         # ignore duplication command history list
setopt share_history

autoload -U zmv
autoload -U _ls
autoload -U zed
autoload -U zftp
autoload -U zcalc

HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000

#-----------------------------------------------------------------
# エイリアス設定
#-----------------------------------------------------------------
#
# UNIX コマンドと Windows 固有のシステムコマンドと区別するために
# 絶対パス指定したり、よく使うコマンドに短い別名を登録したりとか。
# 引数をとるエイリアスは、簡易関数で定義する必要がある点に注意。
#
# tcsh% alias m "mule !* &" → zsh%  m() { mule $* & }
#
#alias ls='ls --show-control-chars --color=auto -Fh'
alias ls='ls -G'
alias ll='ls -tlr'
alias h='history'
alias which='type -path'
alias rehash='hash -r'
alias reload="source ~/.zshrc"
alias -g T='| tail'
alias -g G='| grep'
alias -g Gv='| grep -v'
alias -g W='| wc'
alias -g S='| sed'
alias -g A='| awk'
alias -g U='| uniq'
alias -g So='| sort'
alias -g P='| perl -pe'
alias pd='cd -'
alias psg='ps -aef | grep -v grep | grep '
alias gd='dirs -v; echo -n "select: "; read newdir; cd +"$newdir"'
#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias refe2='${HOME}/Tools/refe/refe-1_9_2 --encoding=utf-8'
alias r='rails'
alias start_mysql='sudo /opt/local/share/mysql55/support-files/mysql.server start'
alias sakura='ssh -p 60022 nori@www11248uf.sakura.ne.jp'

#-----------------------------------------------------------------
# 関数宣言
#-----------------------------------------------------------------
#
#

setenv() { export $1=$2 }

#-----------------------------------------------------------------
# キーバインド設定
#-----------------------------------------------------------------
#
#
autoload history-beginning-search-backward
autoload history-beginning-search-forward
bindkey -e
#bindkey -M
bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
bindkey '^N' history-beginning-search-forward # 先頭マッチのヒストリサーチ
# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

#-----------------------------------------------------------------
# 補完ルール設定
#-----------------------------------------------------------------
#
#
autoload -U compinit
compinit -u
zstyle ':completion:*:default' menu select=1
# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#zstyle ':completion:*:default' menu select true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#-----------------------------------------------------------------
# 起動時処理
#-----------------------------------------------------------------
#
#
#if [ ! "$WINDOW" ]; then
#  exec screen -S main -xRR
#fi
echo "Welcome !!"
echo "  `whoami | tr '[a-z]' '[A-Z]'`   "
echo `date +%Y/%m/%d`
cd


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

compdef _vagrant vagrant
function _vagrant {
  local -a cmds
  if (( CURRENT == 2 ));then
    cmds=('box' 'destroy' 'halt' 'init' 'package' 'plugin' 'provision' 'reload' 'resume' 'snapshot' 'ssh' 'ssh-config' 'status' 'suspend' 'up' 'snapshot')
    _describe -t commands "subcommand" cmds
  else
    _files
  fi

  return 1;
}

################################################################################ 
# Peco 
################################################################################ 
function peco-select-history() { 
typeset tac 
if which tac > /dev/null; then 
tac=tac 
else 
tac='tail -r' 
fi 
BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER" --layout=bottom-up) 
CURSOR=$#BUFFER 
zle -R -c 
} 
zle -N peco-select-history 
bindkey '^r' peco-select-history 

function pcd () { 
local selected_dir=$(find ~/ -type d | peco) 
if [ -n "$selected_dir" ]; then 
BUFFER="cd ${selected_dir}" 
zle accept-line 
fi 
zle clear-screen 
} 
zle -N pcd 

