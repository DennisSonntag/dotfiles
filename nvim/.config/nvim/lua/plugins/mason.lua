return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		local status, mason = pcall(require, "mason")
		if (not status) then return end

		local status2, lspconfig = pcall(require, "mason-lspconfig")
		if (not status2) then return end

		mason.setup({
			ensure_installed = { "bashls", "cssls", "eslint-d", "html", "jsonls", "lua_ls", "tailwindcss", "tsserver",
				"emmet-ls", "prettierd","pyright", "jdtls" },
			automatic_installation = true,
		})

		lspconfig.setup {
			automatic_installation = true
		}
	end
}
