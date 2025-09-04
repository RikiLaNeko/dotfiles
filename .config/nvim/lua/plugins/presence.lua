return {
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require("presence"):setup({
        auto_update = true,
        neovim_image_text = "Neovim on NixOS",
        main_image = "neovim",
        client_id = "793271441293967371", -- ID par défaut pour arRPC
        --log_level = "debug",
        debounce_timeout = 10,
        enable_line_number = false,
        show_time = true,
      })
    end,
  }
}

