local wezterm = require("wezterm")

------------------
-- tabline.wez
------------------
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
    options = {
        -- theme = "catppuccin-mocha",
        theme = "cyberpunk",
        -- theme = "Cobalt Neon",
        section_separators = {
            left = wezterm.nerdfonts.ple_upper_left_triangle,
            right = wezterm.nerdfonts.ple_lower_right_triangle,
        },
        component_separators = {
            left = wezterm.nerdfonts.ple_forwardslash_separator,
            right = wezterm.nerdfonts.ple_forwardslash_separator,
        },
        tab_separators = {
            left = wezterm.nerdfonts.ple_upper_left_triangle,
            right = wezterm.nerdfonts.ple_lower_right_triangle,
        },
        -- color_overrides = {
        theme_overrides = {
            tab = {
                active = { fg = "#091833", bg = "#59c2c6" },
            },
        },
    },
    sections = {
        tab_active = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
        tab_inactive = {
            "index",
            { "process", padding = { left = 0, right = 1 } },
            "󰉋",
            { "cwd",     padding = { left = 1, right = 0 } },
            { "zoomed",  padding = 1 },
        },
    },
})

return {
  ------------------
  -- 基本設定
  ------------------
  font = wezterm.font_with_fallback({
    "HackGen Console NF", "JetBrainsMono Nerd Font", "Noto Sans CJK JP"
  }),
  font_size = 18.0,
  -- color_scheme = "Kasugano (terminal.sexy)",
  color_scheme = "BlulocoDark",
  hide_mouse_cursor_when_typing = true,
  scrollback_lines = 10000,
  enable_wayland = false,
  ------------------
  -- タブ設定
  ------------------
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
  tab_bar_at_bottom = true,
  ------------------
  -- IME
  ------------------
  use_ime = true,
  ime_preedit_rendering = "Builtin",
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
  hide_mouse_cursor_when_typing = true,
  default_cursor_style = "BlinkingBar",
  ------------------
  -- 起動シェル
  ------------------
  default_prog = { "/opt/homebrew/bin/fish", "-l" }, -- `which fish`でパス確認して調整
  -- default_prog = { "/opt/homebrew/bin/fish", "-l", "-c", "tmux attach || tmux" },
  
  ------------------
  -- キーマップ設定
  ------------------
  keys = {
    -- ペイン分割
    { key = "|", mods = "LEADER", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "%", mods = "LEADER", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },

    -- tmux ライクに Leader + h/l/k/j で移動
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection("Up"),
    },
    -- pane zoom
    {
        mods = "LEADER",
        key = "z",
        action = wezterm.action.TogglePaneZoomState,
    },

    -- activate copy mode or vim mode
    {
        mods = "LEADER",
        key = "[",
        action = wezterm.action.ActivateCopyMode,
    },

    -- 新しいタブを開く
    { key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
    -- タブを閉じる
    { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab { confirm = true } },
    -- タブを左右に切り替える
    { key = "h",  mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "l", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
  },

  -- Leaderキー（tmux風）
  leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 },
}
