local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local utils = require "telescope.utils"
local conf = require("telescope.config").values

local flatten = vim.tbl_flatten

local opts_contain_invert = function(args)
  local invert = false
  local files_with_matches = false

  for _, v in ipairs(args) do
    if v == "--invert-match" then
      invert = true
    elseif v == "--files-with-matches" or v == "--files-without-match" then
      files_with_matches = true
    end

    if #v >= 2 and v:sub(1, 1) == "-" and v:sub(2, 2) ~= "-" then
      local non_option = false
      for i = 2, #v do
        local vi = v:sub(i, i)
        if vi == "=" then -- ignore option -g=xxx
          break
        elseif vi == "g" or vi == "f" or vi == "m" or vi == "e" or vi == "r" or vi == "t" or vi == "T" then
          non_option = true
        elseif non_option == false and vi == "v" then
          invert = true
        elseif non_option == false and vi == "l" then
          files_with_matches = true
        end
      end
    end
  end
  return invert, files_with_matches
end

M = {}

M.git_status_live_grep = function(opts)
  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  local search_dirs = opts.search_dirs
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

  if search_dirs then
    for i, path in ipairs(search_dirs) do
      search_dirs[i] = vim.fn.expand(path)
    end
  end

  local additional_args = {}
  if opts.additional_args ~= nil then
    if type(opts.additional_args) == "function" then
      additional_args = opts.additional_args(opts)
    elseif type(opts.additional_args) == "table" then
      additional_args = opts.additional_args
    end
  end

  if opts.type_filter then additional_args[#additional_args + 1] = "--type=" .. opts.type_filter end

  if type(opts.glob_pattern) == "string" then
    additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern
  elseif type(opts.glob_pattern) == "table" then
    for i = 1, #opts.glob_pattern do
      additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern[i]
    end
  end

  local args = flatten { vimgrep_arguments, additional_args }
  opts.__inverted, opts.__matches = opts_contain_invert(args)

  local live_grepper = finders.new_job(function(prompt)
    if not prompt or prompt == "" then return nil end

    local git_cmd = { "git", "diff", "--name-only", "--", "." }

    local output = utils.get_os_command_output(git_cmd, opts.cwd)

    if #output == 0 then
      print "No changes found"
      utils.notify("builtin.git_status", {
        msg = "No changes found",
        level = "WARN",
      })
      return
    end

    return flatten { args, "--", prompt, output }
  end, vim.F.if_nil(opts.entry_maker, make_entry.gen_from_vimgrep(opts)), opts.max_results, opts.cwd)

  -- print "opts"
  -- print(vim.inspect(opts))
  -- print "args"
  -- print(vim.inspect(args))

  pickers
    .new(opts, {
      results_title = "Git Status Live Grep",
      prompt_title = "Git Status Live Grep",
      finder = live_grepper,
      sorter = conf.file_sorter(opts),
      previewer = conf.grep_previewer(opts),
    })
    :find()
end

return M
