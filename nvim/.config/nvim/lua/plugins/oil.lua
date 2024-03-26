return {
	"stevearc/oil.nvim",
	opts = {
		-- Skip the confirmation popup for simple operations
		skip_confirm_for_simple_edits = true,
		-- Deleted files will be removed with the trash_command (below).
		delete_to_trash = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
	},
	keys = function()
		local oil_status, oil = pcall(require, "oil")
		if not oil_status then
			return
		end

		return { { "-", oil.open } }
	end,
}
