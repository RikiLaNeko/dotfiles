local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  "██╗  ██╗██╗   ██╗██████╗  ██████╗ ███╗   ███╗██╗    ██╗   ██╗██╗███╗   ███╗",
  "██║ ██╔╝██║   ██║██╔══██╗██╔═══██╗████╗ ████║██║    ██║   ██║██║████╗ ████║",
  "█████╔╝ ██║   ██║██████╔╝██║   ██║██╔████╔██║██║    ██║   ██║██║██╔████╔██║",
  "██╔═██╗ ██║   ██║██╔══██╗██║   ██║██║╚██╔╝██║██║    ╚██╗ ██╔╝██║██║╚██╔╝██║",
  "██║  ██╗╚██████╔╝██║  ██║╚██████╔╝██║ ╚═╝ ██║██║     ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═══╝  ╚═╝╚═╝     ╚═╝",
}

dashboard.section.buttons.val = {
    { key = "f", icon = "󰈞  ", desc = "Find file", cmd = ":FzfLua files<CR>" },
    { key = "g", icon = "󰊄  ", desc = "Live grep", cmd = ":FzfLua live_grep_native<CR>" },
    { key = "r", icon = "  ", desc = "Recent files", cmd = ":FzfLua oldfiles<CR>" },
    { key = "n", icon = "  ", desc = "New file", cmd = ":ene | startinsert<CR>" },
    { key = "s", icon = "  ", desc = "Restore session", cmd = ":lua require('persistence').load()<CR>" },
    { key = "c", icon = "  ", desc = "Edit config", cmd = ":e $MYVIMRC<CR>" },
    { key = "l", icon = "  ", desc = "Edit lazy", cmd = ":Lazy<CR>" },
    { key = "u", icon = "  ", desc = "Update plugins", cmd = ":Lazy update<CR>" },
    { key = "q", icon = "  ", desc = "Quit", cmd = ":qa<CR>" },
}

-- Footer dynamique : Heure, uptime, nombre de plugins
local datetime = os.date("  %H:%M:%S")
local handle = io.popen("uptime -p | sed 's/up //'")
local uptime = handle:read("*a"):gsub("\n", "")
handle:close()

local plugin_count = #vim.tbl_keys(require("lazy").plugins())

dashboard.section.footer.val = {
  "",
  "♡ KUROMI CYBER SPACE ♡    |   SYSTEM STATUS: ONLINE",
  "",
  "  Plugins loaded: " .. plugin_count .. "      Time: " .. datetime .. "      Uptime: " .. uptime,
  "",
  "\"Knowledge is power, but sharing it is freedom\"",
  "  - Anonymous Collective -",
  "",
  "♡ Powered by Kuromi's rebellious spirit ♡"
}

-- Couleurs Kuromi (texte seulement, fond transparent)
local colors = {
  black   = "#000000",
  hotpink = "#FF69B4",
  purple  = "#800080",
  gray    = "#AAAAAA",
}

vim.cmd("hi AlphaHeader guifg=" .. colors.purple .. " guibg=NONE gui=bold")
vim.cmd("hi AlphaButtons guifg=" .. colors.hotpink .. " guibg=NONE gui=NONE")
vim.cmd("hi AlphaButtonsShortcut guifg=" .. colors.purple .. " guibg=NONE gui=bold")
vim.cmd("hi AlphaFooter guifg=" .. colors.gray .. " guibg=NONE gui=italic")

dashboard.section.header.opts.hl = "AlphaHeader"



dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.config)

