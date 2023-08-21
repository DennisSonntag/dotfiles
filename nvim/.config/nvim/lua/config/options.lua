local o = vim.opt

vim.g.rustinlaytoggle = false

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "resize" }

o.list = true -- Show some invisible characters (tabs...


o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.swapfile = false
o.backup = false

o.scrolloff = 8
o.sidescrolloff = 8

o.completeopt = "menu,menuone,noselect"

o.smartindent = true
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.copyindent = true

o.relativenumber = true
o.nu = true

o.signcolumn = "yes"
o.cursorline = true

o.showmode = false -- Dont show mode since we have a statusline
o.fillchars = { eob = " " }
o.spelllang = { "en" }
o.termguicolors = true
o.errorbells = false

o.splitbelow = true
o.splitright = true

o.incsearch = true
o.hlsearch = false

o.timeoutlen = 1000
o.updatetime = 50

o.showtabline = 0
o.cmdheight = 1
o.hidden = true
o.wrap = false
o.mouse = "a"



local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
