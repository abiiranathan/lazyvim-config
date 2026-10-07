-- Cheatsheet: builtin docs rendered as markdown in a floating popup.
-- Needs render-markdown.nvim (any markdown buffer renders automatically).
local M = {}

M.topics = {
  { id = 'overview', title = 'Start here', file = 'overview.md' },
  { id = 'navigation', title = 'Navigation', file = 'navigation.md' },
  { id = 'keybindings', title = 'Keybindings (this config)', file = 'keybindings.md' },
  { id = 'multicursor', title = 'Multicursor', file = 'multicursor.md' },
  { id = 'macros', title = 'Macros', file = 'macros.md' },
  { id = 'search-replace', title = 'Search & replace', file = 'search-replace.md' },
}

local function find_topic(id)
  for _, t in ipairs(M.topics) do
    if t.id == id then
      return t
    end
  end
end

local function doc_path(file)
  return vim.fn.stdpath('config') .. '/lua/custom/docs/' .. file
end

--- Open a topic in a centered floating window (markdown filetype => rendered).
---@param id string topic id, e.g. 'macros'
function M.open(id)
  local topic = find_topic(id)
  if not topic then
    vim.notify('Cheatsheet: unknown topic "' .. id .. '"', vim.log.levels.ERROR)
    return
  end
  local path = doc_path(topic.file)
  if vim.fn.filereadable(path) == 0 then
    vim.notify('Cheatsheet: missing file ' .. path, vim.log.levels.ERROR)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.fn.readfile(path))
  vim.bo[buf].filetype = 'markdown'
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true

  local width = math.min(math.floor(vim.o.columns * 0.82), 110)
  local height = math.min(math.floor(vim.o.lines * 0.8), 45)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.max(math.floor((vim.o.lines - height) / 2 - 1), 0),
    col = math.max(math.floor((vim.o.columns - width) / 2), 0),
    style = 'minimal',
    border = 'rounded',
    title = ' ' .. topic.title .. ' ',
    title_pos = 'center',
  })
  vim.wo[win].conceallevel = 2
  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].cursorline = true
  vim.wo[win].spell = false

  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true, desc = 'Close cheatsheet' })
  vim.keymap.set('n', '<esc>', '<cmd>close<cr>', { buffer = buf, silent = true, desc = 'Close cheatsheet' })
end

--- Pick a topic via vim.ui.select (floating via ui-select).
function M.pick()
  local items = {}
  for _, t in ipairs(M.topics) do
    items[#items + 1] = string.format('%-14s  %s', t.id, t.title)
  end
  vim.ui.select(items, { prompt = 'Cheatsheet:' }, function(choice)
    if choice then
      M.open(choice:match '^(%S+)')
    end
  end)
end

--- All topic ids, for command completion.
function M.ids()
  local ids = {}
  for _, t in ipairs(M.topics) do
    ids[#ids + 1] = t.id
  end
  return ids
end

return M
