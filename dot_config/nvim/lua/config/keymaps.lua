-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

function OpenFileInMainWindow()
  -- Close the floating window
  local neo_tree_window_found = false

  -- Check if NeoTree window is open
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- Get the buffer associated with the window
    local buf = vim.api.nvim_win_get_buf(win)
    -- Get the `filetype` of the buffer
    local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

    -- If NeoTree is open, we mark it
    if filetype == "neo-tree" then
      neo_tree_window_found = true
      break
    end
  end

  -- If NeoTree is detected, cycle through windows until we find the main window
  if neo_tree_window_found then
    print("NeoTree window found! Skipping...")
    -- Use `wincmd w` but skip over NeoTree
    vim.cmd("2wincmd w") -- This cycles to the next window
  else
    print("No NeoTree window found. Directing to second window.")
    -- Use direct window navigation (you can adjust to another process like jumping to second window)
    vim.cmd("wincmd w") -- Go to the second window (assuming it's the main window)
  end
  -- Switch to the previous window and open the file under the cursor
  vim.cmd("execute 'edit ' . expand('<cfile>')")
end
vim.keymap.del("n", "<leader>l")

vim.keymap.set(
  "n",
  "<leader>gF",
  ":lua OpenFileInMainWindow()<CR>",
  { noremap = true, silent = true, desc = "Open file in main window" }
)

vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true, silent = true, desc = "Paste without rewrite buffer" })
