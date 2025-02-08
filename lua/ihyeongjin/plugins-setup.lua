local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- 플러그인 파일 저장 시 자동으로 PackerSync 실행
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- 테마 (원하는 테마 사용)
	use("ellisonleao/gruvbox.nvim")

	-- Lua 관련 함수 모음
	use("nvim-lua/plenary.nvim")

	-- tmux & split window 네비게이션
	use("christoomey/vim-tmux-navigator")

	use("szw/vim-maximizer")

	-- 기본 플러그인들
	use("tpope/vim-surround")
	use("vim-scripts/ReplaceWithRegister")

	-- 주석 토글
	use("numToStr/Comment.nvim")

	-- 파일 탐색기
	use("nvim-tree/nvim-tree.lua")

	-- 아이콘
	use("kyazdani42/nvim-web-devicons")

	-- 상태줄
	use("nvim-lualine/lualine.nvim")

	-- 퍼지(fuzzy) 찾기
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- 자동 완성
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- 스니펫
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- LSP, Linter, Formatter 설치 및 관리
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("williamboman/nvim-lsp-installer")

	-- LSP 설정
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp") -- 자동 완성용 LSP 소스
	use("jose-elias-alvarez/typescript.nvim") -- typescript 서버 추가 기능
	use("onsails/lspkind.nvim") -- 자동 완성에 VSCode 스타일 아이콘

	-- 포맷팅 및 린팅
	use("jose-elias-alvarez/null-ls.nvim")
	use("jayp0521/mason-null-ls.nvim")

	-- 최신 lspsaga 플러그인 (업데이트된 버전)
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({
				diagnostic = {
					max_height = 0.8,
					keys = {
						quit = { "q", "<ESC>" },
					},
				},
			})
		end,
	})

	-- Treesitter 구문 분석
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- 자동 괄호 완성 및 태그 닫기
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- Git 상태 표시
	use("lewis6991/gitsigns.nvim")

	-- 대시보드
	use({
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				-- 대시보드 설정 (원하는대로 수정)
			})
		end,
		requires = { "nvim-tree/nvim-web-devicons" },
	})

	-- Flutter 개발 도구
	use({
		"akinsho/flutter-tools.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- 선택 UI 개선 (선택사항)
		},
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
