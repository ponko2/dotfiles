local wezterm = require("wezterm")

function basename(path)
	return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. basename(tab.active_pane.foreground_process_name)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return tab.tab_index + 1 .. ": " .. basename(tab.active_pane.foreground_process_name) .. " "
end)

return {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Gruvbox Dark",
	colors = {
		compose_cursor = "orange",
		scrollbar_thumb = "#dddddd",
	},
	enable_scroll_bar = true,
	font = wezterm.font("UDEV Gothic JPDOC"),
	font_size = 18.0,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollToPrompt(1) },
	},
	normalize_to_nfc = true,
	scrollback_lines = 10000,
	text_background_opacity = 0.8,
	treat_east_asian_ambiguous_width_as_wide = true,
	window_background_opacity = 0.8,
}
