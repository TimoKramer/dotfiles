-- Plugin Usage Tracker
-- Tracks how often each installed plugin is loaded across sessions.
-- Use :PluginUsage to view the report.

local data_file = vim.fn.stdpath 'data' .. '/plugin-usage.json'
local session_recorded = {}

local function load_data()
  local f = io.open(data_file, 'r')
  if not f then
    return {}
  end
  local content = f:read '*a'
  f:close()
  local ok, data = pcall(vim.json.decode, content)
  return ok and data or {}
end

local function save_data(data)
  local f = io.open(data_file, 'w')
  if not f then
    return
  end
  f:write(vim.json.encode(data))
  f:close()
end

local function record_plugin(name)
  if session_recorded[name] then
    return
  end
  session_recorded[name] = true
end

local function flush()
  local data = load_data()
  local today = os.date '%Y-%m-%d'
  for name, _ in pairs(session_recorded) do
    if not data[name] then
      data[name] = { sessions = 0, days = {}, last_used = nil }
    end
    data[name].sessions = data[name].sessions + 1
    data[name].days[today] = (data[name].days[today] or 0) + 1
    data[name].last_used = today
  end
  save_data(data)
end

local function show_report()
  local data = load_data()
  local lazy_plugins = require('lazy').plugins()

  -- Build lookup of all installed plugins
  local installed = {}
  for _, plugin in ipairs(lazy_plugins) do
    installed[plugin.name] = true
  end

  -- Merge: show all installed plugins, even if never tracked
  local rows = {}
  for _, plugin in ipairs(lazy_plugins) do
    local name = plugin.name
    local info = data[name]
    local sessions = info and info.sessions or 0
    local last_used = info and info.last_used or 'never'
    local unique_days = 0
    if info and info.days then
      for _ in pairs(info.days) do
        unique_days = unique_days + 1
      end
    end
    local loaded = plugin._.loaded ~= nil
    table.insert(rows, {
      name = name,
      sessions = sessions,
      unique_days = unique_days,
      last_used = last_used,
      loaded_now = loaded,
    })
  end

  -- Sort by sessions descending
  table.sort(rows, function(a, b)
    return a.sessions > b.sessions
  end)

  local lines = {}
  table.insert(lines, string.format('%-35s %8s %6s %12s %s', 'Plugin', 'Sessions', 'Days', 'Last Used', 'Loaded'))
  table.insert(lines, string.rep('-', 80))
  for _, row in ipairs(rows) do
    table.insert(
      lines,
      string.format('%-35s %8d %6d %12s %s', row.name, row.sessions, row.unique_days, row.last_used, row.loaded_now and '*' or '')
    )
  end

  -- Show in a scratch buffer
  vim.cmd 'new'
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.api.nvim_buf_set_name(buf, 'Plugin Usage')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
end

return {
  {
    'folke/lazy.nvim', -- attach to lazy.nvim itself so this runs early
    init = function()
      -- Record eager-loaded plugins after startup
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          for _, plugin in ipairs(require('lazy').plugins()) do
            if plugin._.loaded then
              record_plugin(plugin.name)
            end
          end
        end,
      })

      -- Record lazy-loaded plugins when they load
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyLoad',
        callback = function(event)
          record_plugin(event.data)
        end,
      })

      -- Flush to disk on exit
      vim.api.nvim_create_autocmd('VimLeavePre', {
        once = true,
        callback = flush,
      })

      vim.api.nvim_create_user_command('PluginUsage', show_report, { desc = 'Show plugin usage statistics' })
    end,
  },
}
