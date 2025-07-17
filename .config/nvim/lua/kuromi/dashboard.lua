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

for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaButtonsShortcut"
end

dashboard.section.footer.opts.hl = "AlphaFooter"

alpha.setup(dashboard.config)

