local M = {}

local state_file = (os.getenv("XDG_CACHE_HOME") or (os.getenv("HOME") .. "/.cache")) .. "/hypr/pip-window-position.state"
local state = {}
local last_saved = ""

local function shell_quote(value)
	return "'" .. tostring(value):gsub("'", "'\\''") .. "'"
end

local function ensure_state_dir()
	local dir = state_file:match("^(.+)/[^/]+$")
	if dir then
		hl.exec_cmd("mkdir -p " .. shell_quote(dir))
	end
end

local function parse_line(line)
	local key, x, y = line:match("^(%S+)%s+(-?%d+)%s+(-?%d+)$")
	if key and x and y then
		state[key] = { x = tonumber(x), y = tonumber(y) }
	end
end

local function load_state()
	local file = io.open(state_file, "r")
	if not file then
		return
	end

	for line in file:lines() do
		parse_line(line)
	end

	file:close()
end

local function sorted_keys(t)
	local keys = {}
	for key in pairs(t) do
		keys[#keys + 1] = key
	end
	table.sort(keys)
	return keys
end

local function save_state()
	ensure_state_dir()

	local lines = {}
	for _, key in ipairs(sorted_keys(state)) do
		local pos = state[key]
		if pos and pos.x and pos.y then
			lines[#lines + 1] = string.format("%s %d %d", key, pos.x, pos.y)
		end
	end

	local content = table.concat(lines, "\n") .. "\n"
	if content == last_saved then
		return
	end

	local file = io.open(state_file, "w")
	if not file then
		return
	end

	file:write(content)
	file:close()
	last_saved = content
end

local function coord(value, axis, index)
	if type(value) ~= "table" then
		return nil
	end

	return value[axis] or value[index]
end

local function window_x(window)
	return coord(window.at, "x", 1)
end

local function window_y(window)
	return coord(window.at, "y", 2)
end

local function monitor_name(window)
	if window.monitor and window.monitor.name then
		return window.monitor.name
	end

	return "unknown"
end

local function state_key(window)
	return table.concat({ monitor_name(window), window.class or "", window.title or "" }, "|")
end

local function is_pip(window)
	if not window then
		return false
	end

	local title = window.title or ""
	local class = window.class or ""

	if title == "Picture-in-Picture" then
		return class == "zen" or class == "helium"
	end

	return title == "Picture in picture"
end

local function clamp_to_monitor(window, pos)
	local monitor = window.monitor
	if not monitor then
		return pos
	end

	local min_x = monitor.x or coord(monitor.position, "x", 1) or 0
	local min_y = monitor.y or coord(monitor.position, "y", 2) or 0
	local monitor_w = monitor.width or coord(monitor.size, "x", 1) or 0
	local monitor_h = monitor.height or coord(monitor.size, "y", 2) or 0
	local max_x = min_x + monitor_w - 80
	local max_y = min_y + monitor_h - 80

	return {
		x = math.max(min_x, math.min(pos.x, max_x)),
		y = math.max(min_y, math.min(pos.y, max_y)),
	}
end

local function restore_position(window)
	if not is_pip(window) then
		return
	end

	local pos = state[state_key(window)]
	if not pos then
		return
	end

	pos = clamp_to_monitor(window, pos)
	hl.dispatch(hl.dsp.window.move({ x = pos.x, y = pos.y, window = window }))
end

local function remember_position(window)
	if not is_pip(window) or not window.floating then
		return false
	end

	local x = window_x(window)
	local y = window_y(window)
	if not x or not y then
		return false
	end

	local key = state_key(window)
	local previous = state[key]
	if previous and previous.x == x and previous.y == y then
		return false
	end

	state[key] = { x = x, y = y }
	return true
end

local function remember_all_positions()
	local changed = false
	for _, window in ipairs(hl.get_windows({ floating = true, mapped = true })) do
		changed = remember_position(window) or changed
	end

	if changed then
		save_state()
	end
end

function M.setup()
	load_state()

	hl.on("window.open", function(window)
		restore_position(window)
	end)

	hl.on("window.close", function(window)
		if remember_position(window) then
			save_state()
		end
	end)

	hl.on("hyprland.shutdown", function()
		remember_all_positions()
	end)

	hl.timer(remember_all_positions, { timeout = 1000, type = "repeat" })
end

return M
