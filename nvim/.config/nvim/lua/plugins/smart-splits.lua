return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local status, smart_splits = pcall(require, "smart-splits")
		if (not status) then return end

		vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
		vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
		vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
		vim.keymap.set('n', '<A-l>', smart_splits.resize_right)

		smart_splits.setup({
			-- Ignored filetypes (only while resizing)
			ignored_filetypes = {
				'nofile',
				'quickfix',
				'prompt',
				-- place the cursor on the same row of the *screen*
			},
			-- Ignored buffer types (only while resizing)
			ignored_buftypes = { 'NvimTree' },
			-- when moving cursor between splits left or right,
			-- regardless of line numbers. False by default.
			-- Can be overridden via function parameter, see Usage.
			move_cursor_same_row = false,
			-- resize mode options
			resize_mode = {
				-- key to exit persistent resize mode
				quit_key = '<ESC>',
				-- keys to use for moving in resize mode
				-- in order of left, down, up' right
				resize_keys = { 'h', 'j', 'k', 'l' },
				-- set to true to silence the notifications
				-- when entering/exiting persistent resize mode
				silent = false,
				-- must be functions, they will be executed when
				-- entering or exiting the resize mode
				hooks = {
					on_enter = nil,
					on_leave = nil
				}
			}
		})
	end
}
