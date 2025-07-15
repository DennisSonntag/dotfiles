return {
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
      {
        '<leader>gl',
        function()
          vim.cmd.Git 'log --graph --oneline --decorate'
        end,
      },
      {
        '<leader>ga',
        function()
          vim.cmd.Git 'add .'
        end,
      },
      {
        '<leader>gc',
        function()
          vim.cmd.Git 'commit'
        end,
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
  },
  {
    enabled = false,
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
}
