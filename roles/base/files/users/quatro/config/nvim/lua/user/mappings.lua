local telescope_utils = require "user.util.telescope"

local mappings = {
  n = {
    ["<leader>gs"] = {
      function()
        vim.cmd "vertical Git"
        vim.cmd "vertical resize 80"
      end,
      desc = "Open Fugitive",
    },
    ["<leader>m"] = {
      function() end,
      desc = "Keymap for testing functions",
    },
    ["<leader>fg"] = {
      function() telescope_utils.git_status_live_grep { max_results = 10 } end,
      desc = "Live grep git diff",
    },
  },
}

return mappings
