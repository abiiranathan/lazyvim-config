-- lua/custom/keymap-export.lua

local M = {}

--- Exports all Neovim keymaps to a structured Lua table.
-- Iterates through all modes and collects mappings with their descriptions and options.
-- @return table A structured table containing all keymaps organized by mode.
function M.export_keymaps()
  local modes = {'n', 'i', 'v', 't', 'c', 'o', 'x', 's'}
  local result = {
    generated = os.date("%Y-%m-%d %H:%M:%S"),
    modes = {}
  }
  
  for _, mode in ipairs(modes) do
    local mode_name = ({
      n = "Normal",
      i = "Insert",
      v = "Visual",
      t = "Terminal",
      c = "Command",
      o = "Operator-pending",
      x = "Visual Block",
      s = "Select"
    })[mode]
    
    local keymaps = vim.api.nvim_get_keymap(mode)
    
    -- Sort by lhs (left-hand side / the key)
    table.sort(keymaps, function(a, b)
      return a.lhs < b.lhs
    end)
    
    local mode_mappings = {}
    for _, keymap in ipairs(keymaps) do
      local rhs = keymap.rhs or keymap.callback and "<Lua function>" or ""
      local desc = keymap.desc or ""
      local opts = {}
      
      if keymap.noremap then table.insert(opts, "noremap") end
      if keymap.silent then table.insert(opts, "silent") end
      if keymap.expr then table.insert(opts, "expr") end
      
      table.insert(mode_mappings, {
        lhs = keymap.lhs,
        rhs = rhs,
        desc = desc,
        opts = opts,
        buffer = keymap.buffer or nil,
        nowait = keymap.nowait or false,
        script = keymap.script or false,
      })
    end
    
    result.modes[mode] = {
      name = mode_name,
      mappings = mode_mappings
    }
  end
  
  return result
end

--- Formats the keymaps table into a readable string.
-- @param keymaps table The keymaps data structure returned by export_keymaps()
-- @return string A formatted multi-line string representation
local function format_keymaps(keymaps)
  local output = {}
  
  table.insert(output, "╔══════════════════════════════════════════════════════════════════════════════╗")
  table.insert(output, "║                            NEOVIM KEYMAPS EXPORT                             ║")
  table.insert(output, "╚══════════════════════════════════════════════════════════════════════════════╝")
  table.insert(output, "")
  table.insert(output, string.format("Generated: %s", keymaps.generated))
  table.insert(output, "")
  
  for _, mode in ipairs({'n', 'i', 'v', 't', 'c', 'o', 'x', 's'}) do
    local mode_data = keymaps.modes[mode]
    if mode_data and #mode_data.mappings > 0 then
      table.insert(output, string.rep("─", 80))
      table.insert(output, string.format("  %s MODE (%d mappings)", mode_data.name:upper(), #mode_data.mappings))
      table.insert(output, string.rep("─", 80))
      table.insert(output, "")
      
      for _, mapping in ipairs(mode_data.mappings) do
        local lhs = string.format("%-20s", mapping.lhs)
        local rhs = mapping.rhs
        
        -- Truncate long rhs values
        if #rhs > 50 then
          rhs = rhs:sub(1, 47) .. "..."
        end
        
        local opts_str = ""
        if #mapping.opts > 0 then
          opts_str = string.format(" [%s]", table.concat(mapping.opts, ", "))
        end
        
        table.insert(output, string.format("  %s → %s%s", lhs, rhs, opts_str))
        
        if mapping.desc and mapping.desc ~= "" then
          table.insert(output, string.format("  %s↳ %s", string.rep(" ", 20), mapping.desc))
        end
        
        table.insert(output, "")
      end
    end
  end
  
  table.insert(output, string.rep("═", 80))
  table.insert(output, string.format("Total keymaps exported: %d", 
    vim.tbl_count(vim.tbl_flatten(vim.tbl_map(function(m) return m.mappings end, 
      vim.tbl_values(keymaps.modes))))))
  table.insert(output, string.rep("═", 80))
  
  return table.concat(output, "\n")
end

--- Writes formatted keymaps to a file.
-- @param filepath string The output file path
-- @param keymaps table The keymaps data structure
-- @return boolean Success status
local function write_to_file(filepath, keymaps)
  local formatted = format_keymaps(keymaps)
  local file = io.open(filepath, "w")
  
  if not file then
    return false
  end
  
  file:write(formatted)
  file:close()
  return true
end

--- Sets up the ExportKeymaps command.
function M.setup()
  vim.api.nvim_create_user_command('ExportKeymaps', function(opts)
    local keymaps = M.export_keymaps()
    
    -- If a file path is provided as an argument, write to file
    if opts.args and opts.args ~= "" then
      local filepath = vim.fn.expand(opts.args)
      if write_to_file(filepath, keymaps) then
        vim.notify(string.format("Keymaps exported to: %s", filepath), vim.log.levels.INFO)
      else
        vim.notify(string.format("Failed to write to: %s", filepath), vim.log.levels.ERROR)
      end
    else
      -- Otherwise, write to default location
      local filepath = vim.fn.expand("~/nvim-keymaps.txt")
      if write_to_file(filepath, keymaps) then
        vim.notify(string.format("Keymaps exported to: %s", filepath), vim.log.levels.INFO)
      else
        vim.notify("Failed to export keymaps", vim.log.levels.ERROR)
      end
    end
  end, {
    desc = 'Export all keymaps to a formatted text file',
    nargs = '?', -- Optional argument for custom file path
    complete = 'file', -- Enable file completion
  })
end

return M
