return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      explorer = {
        -- Mengaktifkan hidden file di explorer
        hidden = true,
        -- Mengabaikan aturan .gitignore (opsional, agar file yang di-ignore tetap muncul)
        ignored = true,
      },
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
