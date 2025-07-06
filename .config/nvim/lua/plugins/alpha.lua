return {
  {
    "LazyVim.plugins.extras.ui.alpha",
    enabled = false,
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("kuromi.dashboard")
    end,
  },
}

