local diagnostics = require('config.icons').diagnostics
vim.fn.sign_define('DiagnosticSignError', { text = diagnostics.error, texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = diagnostics.warn, texthl = 'DiagnosticSignWarn', numhl = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = diagnostics.info, texthl = 'DiagnosticSignInfo', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = diagnostics.hint, texthl = 'DiagnosticSignHint', numhl = '' })
