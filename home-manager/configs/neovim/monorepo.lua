-- 1. Define a helper function that:
--    - Reads the $MONOREPO env var
--    - Gets the current file's absolute path
--    - Deduces the relative path
--    - Copies it to the system clipboard
local function copy_relative_to_monorepo()
  local monorepo = vim.fn.expand("$MONOREPO")  -- or os.getenv("MONOREPO")
  if monorepo == "" then
    print("MONOREPO is not set!")
    return
  end

  local filepath = vim.fn.expand("%:p")  -- absolute path of current buffer
  -- Safety check (in case current file is outside of $MONOREPO)
  if not vim.startswith(filepath, monorepo) then
    print("Current file is not inside the MONOREPO path!")
    return
  end

  -- Remove the monorepo portion from the front of the path + the slash
  -- e.g. /home/user/code/monorepo/... => ...
  local relative_path = "$MONOREPO/" .. filepath:sub(#monorepo + 2)

  -- Copy to '+' register (system clipboard) — typically requires `:h clipboard` setup
  vim.fn.setreg("+", relative_path)

  print("Copied relative path to clipboard: " .. relative_path)
end

-- 2. Set up a keybinding. For example, <leader>m
vim.keymap.set("n", "<leader>m", copy_relative_to_monorepo, { desc = "Copy path relative to $MONOREPO" })
