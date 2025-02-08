local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local lspconfig_util_status, lspconfig_util = pcall(require, "lspconfig/util")
if not lspconfig_util_status then
	return
end

local keymap = vim.keymap

-- LSP 연결 시 키맵 설정
local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- lspsaga 관련 키맵
	keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- 정의, 참조 보기
	keymap.set("n", "gD", "<Cmd>Lspsaga goto_definition<CR>", opts) -- 선언으로 이동
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- 정의 미리보기
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- 구현으로 이동
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- 코드 액션 보기
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- 이름 바꾸기
	keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float(nil, { focus = false })<CR>", opts) -- 현재 줄 진단 보기
	keymap.set(
		"n",
		"<leader>d",
		'<cmd>lua vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })<CR>',
		opts
	) -- 커서 위치 진단 보기
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- 이전 진단으로 점프
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- 다음 진단으로 점프
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- 커서 아래 문서 보기
	keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts) -- 아웃라인 보기
	keymap.set("n", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", opts)

	-- TypeScript 전용 키맵
	if client.name == "ts_ls" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", opts) -- 파일 이름 변경 및 import 업데이트
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts) -- import 정리
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts) -- 사용하지 않는 변수 제거
	end
end

-- 자동 완성을 위한 capabilities 설정
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["html"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["cssls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["dartls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["tailwindcss"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["jsonls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["kotlin_language_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["rust_analyzer"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = { group = "module" },
				prefix = "self",
			},
			cargo = {
				buildScripts = { enable = true },
			},
			procMacro = { enable = true },
		},
	},
})

lspconfig["pyright"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = { typeCheckingMode = "off" },
		},
	},
})

lspconfig["sqlls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

-- C/C++: clangd 설정 (offsetEncoding 설정 포함)
local capabilities_cpp = capabilities
capabilities_cpp.offsetEncoding = { "utf-16" }
lspconfig["clangd"].setup({
	on_attach = on_attach,
	capabilities = capabilities_cpp,
})

lspconfig["cmake"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["jdtls"].setup({
	cmd = { "jdtls" },
	filetypes = { "java" },
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = lspconfig_util.root_pattern(
		".git",
		"build.gradle",
		"pom.xml",
		"settings.gradle",
		"build.gradle.kts",
		"settings.gradle.kts"
	),
	single_file_support = true,
})
