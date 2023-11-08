local status, _ = pcall(vim.cmd, "colorscheme ghdark")
if not status then
	print("Colorscheme not found!")
	return
end
