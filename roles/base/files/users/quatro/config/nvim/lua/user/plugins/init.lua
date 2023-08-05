-- https://github.com/kylechui/nvim-surround/blob/main/lua/nvim-surround/config.lua
-- https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt

return {
  { "tpope/vim-fugitive", event = "User AstroGitFile" },
  {
    "kylechui/nvim-surround",
    event = "User AstroFile",
    opts = {
      keymaps = {
        normal = "sa",
        normal_cur = "sv",
        normal_line = "ss",
        normal_cur_line = "sS",
        visual = "s",
        delete = "sd",
        change = "sr",
      },
      aliases = {
        ["u"] = { "}", "]", ")", ">", '"', "'", "`" },
      },
    },
  },
}
