local M = {}

function M.run()
    if vim.bo.filetype == 'rust' then
        vim.cmd('silent wa | term cargo run')
    elseif vim.bo.filetype == 'go' then
        vim.cmd('silent wa | term go build && go run .')
    end
end

function M.build()
    if vim.bo.filetype == 'go' then
        vim.cmd('silent wa | term go build')
    end
end

function M.test()
    if vim.bo.filetype == 'go' then 
        vim.cmd('silent wa | term go test')
    end
end

return M
