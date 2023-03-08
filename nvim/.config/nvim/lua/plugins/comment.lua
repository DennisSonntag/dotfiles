return {
	'numToStr/Comment.nvim',
	dependencies = 'JoosepAlviste/nvim-ts-context-commentstring',
	config = function()
		local status, comment = pcall(require, "Comment")
		if (not status) then return end

		comment.setup({
			pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
		})
	end
}
