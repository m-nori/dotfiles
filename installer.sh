#!/bin/bash
set -eu

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== dotfiles installer ==="
echo "dotfiles dir: $DOTFILES_DIR"
echo ""

#-----------------------------------------
# Homebrew
#-----------------------------------------
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#-----------------------------------------
# brew install
#-----------------------------------------
echo "Installing packages..."
brew install \
  neovim \
  fish \
  fzf \
  zoxide \
  direnv \
  tmux \
  pyenv \
  nodebrew \
  deno \
  bat

brew install --cask wezterm

#-----------------------------------------
# fish shell
#-----------------------------------------
FISH_PATH="/opt/homebrew/bin/fish"
if ! grep -q "$FISH_PATH" /etc/shells; then
  echo "Adding fish to /etc/shells..."
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

#-----------------------------------------
# Oh My Fish
#-----------------------------------------
if [ ! -d "$HOME/.local/share/omf" ]; then
  echo "Installing Oh My Fish..."
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

#-----------------------------------------
# シンボリックリンク作成
#-----------------------------------------
echo ""
echo "Creating symlinks..."

link() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "  backup: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  $dst -> $src"
}

link "$DOTFILES_DIR/init.lua"     "$HOME/.config/nvim/init.lua"
link "$DOTFILES_DIR/config.fish"  "$HOME/.config/fish/config.fish"
link "$DOTFILES_DIR/wezterm.lua"  "$HOME/.config/wezterm/wezterm.lua"
link "$DOTFILES_DIR/.tmux.conf"   "$HOME/.tmux.conf"

# Claude Code
link "$DOTFILES_DIR/.claude/CLAUDE.md"                          "$HOME/.claude/CLAUDE.md"
link "$DOTFILES_DIR/.claude/skills/commit/SKILL.md"             "$HOME/.claude/skills/commit/SKILL.md"
link "$DOTFILES_DIR/.claude/skills/push/SKILL.md"               "$HOME/.claude/skills/push/SKILL.md"
link "$DOTFILES_DIR/.claude/skills/merge/SKILL.md"              "$HOME/.claude/skills/merge/SKILL.md"
link "$DOTFILES_DIR/.claude/skills/slides-maker/SKILL.md"       "$HOME/.claude/skills/slides-maker/SKILL.md"
link "$DOTFILES_DIR/.claude/skills/slides-maker/references/design-en.md"     "$HOME/.claude/skills/slides-maker/references/design-en.md"
link "$DOTFILES_DIR/.claude/skills/slides-maker/references/design-ja.md"     "$HOME/.claude/skills/slides-maker/references/design-ja.md"
link "$DOTFILES_DIR/.claude/skills/slides-maker/references/design-system.md" "$HOME/.claude/skills/slides-maker/references/design-system.md"

echo ""
echo "=== Done! ==="
echo "Restart your terminal or run: exec fish"
