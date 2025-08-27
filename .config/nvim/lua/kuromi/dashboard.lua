-- dashboard.lua
-- Configuration for the alpha-nvim dashboard plugin.

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- =============================================================================
-- Header Section
-- =============================================================================
-- ASCII art for the header.
dashboard.section.header.val = {
  "██╗  ██╗██╗   ██╗██████╗  ██████╗ ███╗   ███╗██╗    ██╗   ██╗██╗███╗   ███╗",
  "██║ ██╔╝██║   ██║██╔══██╗██╔═══██╗████╗ ████║██║    ██║   ██║██║████╗ ████║",
  "█████╔╝ ██║   ██║██████╔╝██║   ██║██╔████╔██║██║    ██║   ██║██║██╔████╔██║",
  "██╔═██╗ ██║   ██║██╔══██╗██║   ██║██║╚██╔╝██║██║    ╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║  ██╗╚██████╔╝██║  ██║╚██████╔╝██║ ╚═╝ ██║██║     ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

-- =============================================================================
-- Buttons Section
-- =============================================================================
-- Dashboard buttons for common actions.
dashboard.section.buttons.val = {
  dashboard.button("f", "󰈞  Find file", ":FzfLua files<CR>"),
  dashboard.button("g", "󰊄  Live grep", ":FzfLua live_grep_native<CR>"),
  dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
  dashboard.button("n", "  New file", ":ene | startinsert<CR>"),
  dashboard.button("s", "  Restore session", ":lua require('persistence').load()<CR>"),
  dashboard.button("c", "  Edit config", ":e $MYVIMRC<CR>"),
  dashboard.button("l", "  Edit lazy", ":Lazy<CR>"),
  dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
  dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- =============================================================================
-- Footer Section
-- =============================================================================
-- Helper function to get system uptime.
local function get_uptime()
  local handle = io.popen("uptime -p | sed 's/up //'")
  if not handle then
    return ""
  end
  local uptime_str = handle:read("*a"):gsub("
", "")
  handle:close()
  return uptime_str
end

-- Dynamic footer content.
local plugin_count = #vim.tbl_keys(require("lazy").plugins())
local current_time = os.date("  %H:%M:%S")
local system_uptime = get_uptime()

local footer_line = string.format(
  "  Plugins loaded: %d    %s      Uptime: %s",
  plugin_count,
  current_time,
  system_uptime
)

dashboard.section.footer.val = {
  "",
  "♡ KUROMI CYBER SPACE ♡    |   SYSTEM STATUS: ONLINE",
  "",
  footer_line,
  "",
  ""Knowledge is power, but sharing it is freedom"",
  "  - Anonymous Collective -",
  "",
  "♡ Powered by Kuromi's rebellious spirit ♡",
}

-- =============================================================================
-- Colors and Highlights
-- =============================================================================
-- Kuromi color palette (with transparent background).
local colors = {
  black = "#000000",
  hotpink = "#FF69B4",
  purple = "#800080",
  gray = "#AAAAAA",
}

-- Set highlight groups for dashboard elements.
vim.cmd("hi AlphaHeader guifg=" .. colors.purple .. " guibg=NONE gui=bold")
vim.cmd("hi AlphaButtons guifg=" .. colors.hotpink .. " guibg=NONE gui=none")
vim.cmd("hi AlphaButtonsShortcut guifg=" .. colors.purple .. " guibg=NONE gui=bold")
vim.cmd("hi AlphaFooter guifg=" .. colors.gray .. " guibg=NONE gui=italic")

dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"

-- =============================================================================
-- Final Setup
-- =============================================================================
alpha.setup(dashboard.config)