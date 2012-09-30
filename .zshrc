#-----------------------------------------------------------------
# 基本設定
#-----------------------------------------------------------------
HISTSIZE=10000
SAVEHIST=10000

#-----------------------------------------------------------------
# 環境変数
#-----------------------------------------------------------------
# setup shell dir
#SHELL=/home/apexei/bad01i/tools/local/bin/zsh
#export SHELL

#EXEC_PREFIX=/home/apexei/bad01i/tools/local/bin
#export EXEC_PREFIX

# set path
#PATH=/home/apexei/bad01i/tools/local/bin:/home/apexei/bad01i/tools/local/#export PATH
PATH=/opt/local/bin:${PATH}:/opt/local/sbin:${HOME}/.gem/ruby/1.9.1/bin:/usr/local/git/bin
export PATH

export MANPATH=/opt/local/man:$MANPATH

source ~/.rvm/scripts/rvm
rvm 1.9.3
rvm gemset use mygemset

#CLASSPATH
#export CLASSPATH=${CLASSPATH}:.
export LANG=ja_JP.SJIS
export TZ=JST-9
export JLESSCHARSET=japanese-sjis
export LESSCHARSET=dos

#expor  LISTMAX=10000
#export  EDITOR=vi
#export JLESSCHARSET=japanese-sijs
#export LESSCHARSET=japanese-sjis
#export  PAGER=more
export LS_COLORS='di=01;36'

#-----------------------------------------------------------------
# プロンプト
#-----------------------------------------------------------------
# ユーザ名・ホスト名を左プロンプト表示、カレントディレクトリ名は
# 右プロンプト表示する。日本語のディレクトリ名も表示できるように、
# precmd() を使って毎回設定しなおしてみた。
#

# プロンプトのカラー表示を有効
autoload -U colors
colors
usernam=`whoami`
setopt prompt_subst

#PROMPT="${LOGNAME}%{$fg[white]%}@%{$reset_color%}Side%{$fg[white]%}:%{$reset_color%}${side}%{$fg[white]%} $ %{$reset_color%}"
#RPROMPT='%{$fg[white]%}%~%{$reset_color%}:%{$fg[white]%}%!%{$reset_color%}'

PROMPT=\
"${usernam}%{$fg[white]%}@%{$reset_color%}MacBookPro %~%{$fg[white]%}:%{$reset_color%}%!"\
$'\n%{$fg[white]%}%#%{$reset_color%} '


#-----------------------------------------------------------------
# シェル変数設定
#-----------------------------------------------------------------
#
# シェルの基本的な動作を変更するスイッチは、ほぼシステム非依存。
setopt  always_last_prompt      # 無駄なスクロールを避ける
setopt  append_history          # ヒストリファイルに追加
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
setopt append_history # 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt share_history



autoload -U zmv
autoload -U _ls
autoload -U zed
autoload -U zftp
autoload -U zcalc


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
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias refe2='${HOME}/Tools/refe/refe-1_9_2 --encoding=utf-8'
alias r='rails'
alias start_mysql='sudo /opt/local/share/mysql55/support-files/mysql.server start'
alias sakura='ssh -p 60022 nori@www11248uf.sakura.ne.jp'

#-----------------------------------------------------------------
# 関数宣言
#-----------------------------------------------------------------
#

#chpwd() {
#  FILE=`ls | wc -l`
#  BASE=30
#  BASE2=100
#  if [ ${FILE} -lt ${BASE} ]
#  then
#    ls -trl
#  else
#    if [ ${FILE} -lt ${BASE2} ]
# then
# ls
# fi
#  fi
#}

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
# 終了時処理
#-----------------------------------------------------------------
#
#
#trap "banner 'logout';banner '${usernam}'" 0

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


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
