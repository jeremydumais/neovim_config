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

function M.coverage()
    if vim.bo.filetype == 'go' then
        vim.cmd('term go test -coverprofile cover.out && go tool cover -html cover.out -o cover.html')
    end
end
return M
