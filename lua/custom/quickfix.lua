-- Quick Fix helpers: auto-fix that tells you what happened instead of failing silently.
local M = {}

--- Does this LSP action look like a quick fix / import fix?
---@param action table LSP Command or CodeAction
---@return boolean
function M.is_quickfix(action)
  if type(action) ~= 'table' or type(action.title) ~= 'string' then
    return false
  end
  if action.kind == 'quickfix' then
    return true
  end
  if action.isPreferred then
    return true
  end
  local title = action.title:lower()
  return title:find('fix', 1, true) ~= nil or title:find('import', 1, true) ~= nil
end

-- Apply one fully-resolved action (edit and/or command).
-- Returns false when the server must resolve it first (fall back to the menu).
---@return boolean applied
local function apply_one(client, bufnr, action)
  local did = false
  if action.edit ~= nil then
    vim.lsp.util.apply_workspace_edit(action.edit, (client and client.offset_encoding) or 'utf-16')
    did = true
  end
  if type(action.command) == 'table' and client and type(client.exec_cmd) == 'function' then
    did = pcall(client.exec_cmd, client, action.command, { bufnr = bufnr }) or did
  end
  return did
end

-- LSP-shaped diagnostics under the cursor for the codeAction context.
-- Raw vim.diagnostic items lack `range`, which strict servers (clangd)
-- reject with InvalidParams; the originals live at `user_data.lsp`.
-- Items without it (e.g. linters) are skipped.
local function context_diagnostics(bufnr, lnum, col)
  local out = {}
  for _, d in ipairs(vim.diagnostic.get(bufnr, { lnum = lnum })) do
    local lsp_diag = type(d.user_data) == 'table' and d.user_data.lsp or nil
    if type(lsp_diag) == 'table' and lsp_diag.range ~= nil then
      local end_lnum = d.end_lnum or d.lnum
      local end_col = d.end_col or d.col
      local ok = lnum >= d.lnum and lnum <= end_lnum
      if ok and lnum == d.lnum and col < d.col then
        ok = false
      end
      if ok and lnum == end_lnum and col > end_col then
        ok = false
      end
      if ok then
        out[#out + 1] = lsp_diag
      end
    end
  end
  return out
end

---@param opts table|nil { only: string[]|nil, match: fun|nil, empty_msg: string|nil }
function M.run(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/codeAction' })
  if #clients == 0 then
    vim.notify('Quick Fix: no LSP attached', vim.log.levels.WARN)
    return
  end
  -- NOTE: make_range_params takes a *window* (0 = current), not a buffer.
  local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding or 'utf-16')
  local cursor = vim.api.nvim_win_get_cursor(0)
  params.context = {
    diagnostics = context_diagnostics(bufnr, cursor[1] - 1, cursor[2]),
    triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
  }
  if opts.only then
    params.context.only = opts.only
  end
  -- Generous timeout: servers like clangd may query the index for fixes.
  local responses = vim.lsp.buf_request_sync(bufnr, 'textDocument/codeAction', params, 5000) or {}
  local gathered = {}
  for client_id, resp in pairs(responses) do
    if type(resp) == 'table' and resp.err == nil then
      for _, action in ipairs(resp.result or {}) do
        if type(action) == 'table' and (opts.match == nil or opts.match(action)) then
          gathered[#gathered + 1] = { client_id = client_id, action = action }
        end
      end
    end
  end
  if #gathered == 0 then
    vim.notify(opts.empty_msg or 'No code actions available', vim.log.levels.INFO)
    return
  end
  if #gathered == 1 then
    local one = gathered[1]
    if apply_one(vim.lsp.get_client_by_id(one.client_id), bufnr, one.action) then
      return
    end
    -- Needs server-side resolve: fall through to the menu.
  end
  if opts.only then
    vim.lsp.buf.code_action({ context = { only = opts.only, diagnostics = params.context.diagnostics } })
  else
    require('actions-preview').code_actions()
  end
end

--- Auto-apply the quick fix when there is exactly one; pick from a
--- diff-preview menu when several; tell you when there are none.
function M.auto_fix()
  M.run({ match = M.is_quickfix, empty_msg = 'No auto-fix available here' })
end

--- Organize imports (or tell you when unsupported).
function M.organize_imports()
  M.run({ only = { 'source.organizeImports' }, empty_msg = 'No organize-imports action available' })
end

return M
