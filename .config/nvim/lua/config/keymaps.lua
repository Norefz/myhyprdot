-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
return {
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      { "<leader>cc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
    },
    opts = {
      save_path = "~/Pictures/Snapshot",
      has_breadcrumbs = true,
      bg_theme = "bamboo",
    },
  },
  require("FTerm").setup({
    border = "rounded",
    blend = 0,
    on_exit = nil,
    dimensions = {
      height = 0.6,
      width = 0.6,
      x = 0.5,
      y = 0.5,
    },
  }),
  --Fterm Terminal
  vim.keymap.set("n", "<C-t>", function()
    require("FTerm").open()
  end, { silent = true, desc = "Open FTerm Terminal" }),

  vim.keymap.set("n", "<C-x>", function()
    require("FTerm").exit()
  end, { silent = true, desc = "Close Fterm Terminal" }),

  require("codesnap").setup({
    -- The "default" background is one you see at the beginning of the README
    bg_theme = "summer",
    watermark = "",
    has_breadcrumbs = true,
  }),
  require("live-server").setup(opts),
}
