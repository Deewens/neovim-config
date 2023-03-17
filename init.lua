-- disable netrw (should stay at the beginning of init.lua file) - for nvim-tree.lua plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 4 -- Number of column taken by the \t char (TAB)
vim.opt.shiftwidth=4 -- Governs indentation via >> (whatever this is? Seems related to Normal Mode indentation but I don't know)
vim.opt.expandtab=true -- Replace indentation (made with tabstop or shiftwidth) with space characters
vim.opt.termguicolors=true -- set termguicolors to enable highlight groups
vim.opt.number=true -- Display line numbers
vim.opt.numberwidth=3 -- Line number column's width

-- Color scheme
vim.cmd.colorscheme("darcula")

-- Bufferline.nvim
require("bufferline").setup{}

-- nvim-tree.lua
require("nvim-tree").setup()

local function open_nvim_tree(data)

  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Auto close nvim-tree (Minimum viable solution, likely to fail for complex nvim setups)
-- See: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})
