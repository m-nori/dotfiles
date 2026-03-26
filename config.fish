#-----------------------------------------------------------------
# PATH
#-----------------------------------------------------------------
set -x PATH /usr/local/bin $PATH
set -x PATH /opt/homebrew/bin $PATH
set -x PATH $HOME/.pyenv/shims $PATH
set -x PATH $HOME/.nodebrew/current/bin $PATH
set -x PATH $HOME/Tools $PATH
set -x PATH $HOME/.local/bin $PATH
set -x CLAUDE_IDE code-vscode

#-----------------------------------------------------------------
# 環境変数
#-----------------------------------------------------------------
export LSCOLORS=xbfxcxdxbxegedabagacad
#set -x LANG C.UTF-8
set LANG ja_JP.UTF-8
set -Ux EDITOR nvim
set -Ux VISUAL nvim

#-----------------------------------------------------------------
# エイリアス設定
#-----------------------------------------------------------------
alias ll='ls -tlr'
alias which='type -path'
alias vi='nvim'
alias reload='. ~/.config/fish/config.fish'

# direnvを有効化
direnv hook fish | source

#-----------------------------------------------------------------
# fish設定
#-----------------------------------------------------------------
# プロンプト: tide (fisher install IlanCosman/tide@v6)

# zoxide（ディレクトリ履歴）
zoxide init fish | source

# ディレクトリ履歴移動（Ctrl + ]）
function fzf_change_directory
  set dir (zoxide query -l | fzf --layout=reverse --height=40%)
  if test -n "$dir"
    cd $dir
  end
end

# ⌨️ コマンド履歴検索（Ctrl + R）
function fzf_history
  set cmd (history | fzf --tac --preview 'echo {}' --height=40%)
  if test -n "$cmd"
    commandline --replace "$cmd"
  end
end

# 🎹 キーバインド設定
function fish_user_key_bindings
  bind \c] fzf_change_directory  # Ctrl + ] でディレクトリ移動
  bind \cr fzf_history           # Ctrl + R で履歴検索
end

