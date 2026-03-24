# dotfiles

macOS 向けの個人dotfiles。Neovim / fish shell / WezTerm / tmux の設定を管理。

## 構成

```
dotfiles/
├── init.lua        # Neovim 設定 (メイン)
├── config.fish     # fish shell 設定
├── wezterm.lua     # WezTerm ターミナル設定
├── .tmux.conf      # tmux 設定
└── installer.sh    # セットアップスクリプト
```

## セットアップ

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./installer.sh
```

以下を自動で行います:

1. **Homebrew** のインストール (未導入の場合)
2. **パッケージのインストール**: neovim, fish, fzf, zoxide, direnv, tmux, pyenv, nodebrew, deno, wezterm
3. **fish shell** を `/etc/shells` に追加
4. **Oh My Fish** のインストール
5. **シンボリックリンクの作成** (既存ファイルは `.bak` にバックアップ)
   - `init.lua` -> `~/.config/nvim/init.lua`
   - `config.fish` -> `~/.config/fish/config.fish`
   - `wezterm.lua` -> `~/.config/wezterm/wezterm.lua`
   - `.tmux.conf` -> `~/.tmux.conf`

### インストールされるパッケージ

| パッケージ | 用途 |
|-----------|------|
| neovim | エディタ |
| fish | シェル |
| fzf | ファジーファインダー |
| zoxide | ディレクトリ履歴 (z の後継) |
| direnv | ディレクトリ単位の環境変数管理 |
| tmux | ターミナルマルチプレクサ |
| pyenv | Python バージョン管理 |
| nodebrew | Node.js バージョン管理 |
| deno | JavaScript/TypeScript ランタイム |
| bat | cat の代替 (シンタックスハイライト付き) |
| wezterm (cask) | ターミナルエミュレータ |

## 各設定ファイルの詳細

---

### init.lua (Neovim)

プラグイン管理は **lazy.nvim**。Leader キーは `,`。

#### 基本設定

| 設定 | 値 |
|------|-----|
| インデント | スペース 2 |
| クリップボード | システム連携 (`unnamedplus`) |
| シェル | fish |
| カーソル移動 | accelerated-jk で加速 |

#### プラグイン一覧

**UI**
| プラグイン | 用途 |
|-----------|------|
| tokyonight.nvim | カラースキーム |
| dashboard-nvim | 起動画面 |
| lualine.nvim | ステータスライン |
| indent-blankline.nvim | インデントガイド |
| gitsigns.nvim | Git差分サイン + 行blame表示 |
| nvim-scrollbar | スクロールバー (diagnostics/gitsigns/search連携) |
| nvim-hlslens | 検索ハイライト強化 |
| dropbar.nvim | パンくずナビゲーション |

**Markdown**
| プラグイン | 用途 |
|-----------|------|
| markview.nvim | Markdownのリッチプレビュー (バッファ内) |
| peek.nvim | Markdownブラウザプレビュー (Deno) |

**ファイラー / 検索**
| プラグイン | 用途 |
|-----------|------|
| telescope.nvim | ファジーファインダー |
| telescope-file-browser.nvim | ファイルブラウザ拡張 |

**LSP / 補完**
| プラグイン | 用途 |
|-----------|------|
| nvim-lspconfig | LSP設定 |
| mason.nvim / mason-lspconfig.nvim | LSPサーバー自動管理 |
| nvim-cmp | 補完エンジン (LSP/buffer/path/snippet) |
| LuaSnip | スニペットエンジン |

**Git**
| プラグイン | 用途 |
|-----------|------|
| vim-fugitive | Gitコマンド統合 |
| diffview.nvim | diff ビューワー |
| neogit | Magit風Git UI |

**その他**
| プラグイン | 用途 |
|-----------|------|
| nvim-treesitter | シンタックスハイライト / インデント |
| toggleterm.nvim | ターミナル (`Ctrl+]` で開閉) |
| Comment.nvim | コメントトグル |
| which-key.nvim | キーバインドヘルプ表示 |
| accelerated-jk.nvim | j/k 移動の加速 |

#### キーバインド

| キー | モード | 動作 |
|------|--------|------|
| `jj` | Insert | Escapeに戻る |
| `q` | Normal | Escape |
| `,w` | Normal | 保存 |
| `,q` | Normal | バッファを閉じる |
| `ff` | Normal | Telescope: バッファ一覧 |
| `fb` | Normal | Telescope: ファイルブラウザ |
| `fs` | Normal | Telescope: ファイル検索 (hidden含む) |
| `fg` | Normal | Telescope: live grep |
| `fd` | Normal | Telescope: git status |
| `,gd` | Normal | Git diff split |
| `,gn` | Normal | Neogit を開く |
| `,d` | Normal | Dropbar をプロジェクトルートから開く |
| `,mv` | Normal | Markview トグル |
| `,mp` | Normal | Markdown ブラウザプレビュー トグル |
| `]c` / `[c` | Normal | 次/前の Git hunk へ移動 |
| `Ctrl+]` | Normal | ToggleTerm 開閉 |
| `Esc` | Terminal | ターミナルからノーマルモードへ |
| `Ctrl+a/e/n/p/b/f/h/d` | Insert | Emacs風カーソル移動 |

---

### config.fish (fish shell)

| 項目 | 内容 |
|------|------|
| テーマ | bobthefish (Oh My Fish) |
| エディタ | nvim |
| PATH | homebrew, pyenv, nodebrew, ~/.local/bin |
| direnv | 有効 |
| `Ctrl+]` | zoxide + fzf でディレクトリ履歴移動 |
| `Ctrl+R` | fzf でコマンド履歴検索 |

---

### wezterm.lua (WezTerm)

| 項目 | 内容 |
|------|------|
| フォント | HackGen Console NF / JetBrainsMono Nerd Font (18pt) |
| カラースキーム | BlulocoDark |
| タブバー | 下部表示、tabline.wez プラグイン (cyberpunk テーマ) |
| Leader キー | `Ctrl+T` (tmux風) |
| IME | 有効 (macOS) |
| シェル | fish |

**キーバインド**

| キー | 動作 |
|------|------|
| `Leader + \|` | 水平分割 |
| `Leader + %` | 垂直分割 |
| `Leader + h/j/k/l` | ペイン移動 |
| `Leader + z` | ペインズーム |
| `Leader + [` | コピーモード |
| `Cmd + T` | 新規タブ |
| `Cmd + W` | タブを閉じる |
| `Cmd + H/L` | タブ切り替え |

---

### .tmux.conf (tmux)

| 項目 | 内容 |
|------|------|
| Prefix | `Ctrl+T` |
| モード | vi |
| シェル | fish |
| ステータスバー | powerline |
| 色 | 256色 |

**主なキーバインド**

| キー | 動作 |
|------|------|
| `Prefix + \|` | ペイン分割 |
| `Prefix + h/j/k/l` | ペイン移動 |
| `Prefix + H/J/K/L` | ペインリサイズ |
| `Prefix + n/p` | 次/前のウィンドウ |
| `Prefix + K` | ウィンドウ削除 |
| `Prefix + A` | ウィンドウ名変更 |
