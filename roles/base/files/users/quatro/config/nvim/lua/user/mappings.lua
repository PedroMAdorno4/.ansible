local telescope_utils = require "user.util.telescope"
local harpoon = require "harpoon"

local mappings = {
  n = {
    ["<leader>gs"] = {
      function()
        vim.cmd "vertical Git"
        vim.cmd "vertical resize 80"
      end,
      desc = "Open Fugitive",
    },
    ["K"] = {
      function() vim.lsp.buf.hover() end,
      desc = "Lsp Hover",
    },
    ["<leader>m"] = {
      function() end,
      desc = "Keymap for testing functions",
    },
    ["<leader>fg"] = {
      function() telescope_utils.git_status_live_grep { max_results = 10 } end,
      desc = "Live grep git diff",
    },
    ["<leader>a"] = {
      function() harpoon:list():append() end,
    },
    ["<C-e>"] = {
      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    },
    ["<C-h>"] = {
      function() harpoon:list():select(1) end,
    },
    ["<C-j>"] = {
      function() harpoon:list():select(2) end,
    },
    ["<C-k>"] = {
      function() harpoon:list():select(3) end,
    },
    ["<C-l>"] = {
      function() harpoon:list():select(4) end,
    },
    ["<C-S-p>"] = {
      function() harpoon:list():prev() end,
    },
    ["<C-S-n>"] = {
      function() harpoon:list():next() end,
    },
  },
}

return mappings
