local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local lualine_kanagawa = require("lualine.themes.kanagawa")

local new_colors = {
	blue = "#A3D4D5",
	green = "#76946A",
	violet = "#957FB8",
	yellow = "#DCA561",
	black = "#000000",
}

lualine_kanagawa.normal.a.bg = new_colors.blue
lualine_kanagawa.insert.a.bg = new_colors.green
lualine_kanagawa.visual.a.bg = new_colors.violet
lualine_kanagawa.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, -- black
	},
}

lualine.setup({
	options = {
		theme = lualine_kanagawa,
	},
})
