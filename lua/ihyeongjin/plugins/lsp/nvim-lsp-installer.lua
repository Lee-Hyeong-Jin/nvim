local status, nvim_lsp_installer = pcall(require, "nvim-lsp-installer")
if not status then
	return
end

nvim_lsp_installer.setup()
