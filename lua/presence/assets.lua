---@diagnostic disable: undefined-global
---
--- FileAssets: File asset definitions (name, source) keyed by file name or extension
--- * name - the name of the asset shown as the title of the file in Discord
--- * source - the source of the asset, either an art asset key or the URL of an image asset
---
--- @class FileAssets
--- @field name string
--- @field source string

local decode = vim.json and vim.json.decode or vim.fn.json_decode

local file_path = debug.getinfo(1, "S").source:match("^@(.+/)assets%.lua$") .. "assets.json"
local file = io.open(file_path, "r")
if not file then
    vim.schedule(function()
        vim.notify("[presence.nvim] Warning: Could not open file_assets.json at: " .. file_path, vim.log.levels.WARN)
    end)
    return {}
end

local content = file:read("*a")
file:close()

local ok, data = pcall(decode, content)
if not ok then
    vim.schedule(function()
        vim.notify("[presence.nvim] Warning: Failed to decode file_assets.json: " .. tostring(data), vim.log.levels.WARN)
    end)
    return {}
end

return data
