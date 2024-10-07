local _m = {
	terminal = os.getenv("TERMINAL") or "kitty",
	editor = os.getenv("EDITOR") or "nvim",
	browser = "firefox",
	browser_alt = "brave",
	filebrowser = "thunar",
}

_m.editor_cmd = _m.terminal .. " -e " .. _m.editor

return _m
