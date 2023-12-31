local M = {}

function M.clear_project()
    vim.g.projectbuild = nil
    print("All projects will be built!")
end

function M.set_project(project_name)
    if project_name == '"*"' or project_name == '""' then
        M.clear_project()
    else
        vim.g.projectbuild = project_name
        print("Current project is now set to " .. project_name)
    end
end

function M.get_cpp_what_to_build()
    local what_to_build = '.'
    if vim.g.projectbuild ~= nil then
        what_to_build = vim.g.projectbuild
    end
    return what_to_build
end

function M.run()
    vim.g.buf_num = vim.fn.bufnr('%')
    vim.keymap.set("n", "<C-e>", string.format("<cmd>bp|bd #|buffer %d<cr>", vim.g.buf_num))
    if vim.bo.filetype == 'rust' then
        vim.cmd('silent wa | term cargo run')
    elseif vim.bo.filetype == 'go' then
        vim.cmd('silent wa | term go build && go run .')
    elseif vim.bo.filetype == 'cpp' then
        if vim.g.cpprun == nil then
            print("You must first define the cpprun variable like this :lua vim.g.cpprun = '<binaryToRun>'")
            return
        end
        vim.cmd('silent wa | term cd build && cmake --build ' .. M.get_cpp_what_to_build() ..' --parallel 8 && ./' .. vim.g.cpprun)
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    end
end

function M.build()
    vim.g.buf_num = vim.fn.bufnr('%')
    vim.keymap.set("n", "<C-e>", string.format("<cmd>bp|bd #|buffer %d<cr>", vim.g.buf_num))
    if vim.bo.filetype == 'rust' then
        vim.cmd('silent wa | term cargo build')
    elseif vim.bo.filetype == 'go' then
        vim.cmd('silent wa | term go build')
    elseif vim.bo.filetype == 'cpp' then
        vim.cmd('silent wa | term cd build && cmake --build ' .. M.get_cpp_what_to_build() .. ' --parallel 8')
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    end
end

function M.test()
    vim.g.buf_num = vim.fn.bufnr('%')
    vim.keymap.set("n", "<C-e>", string.format("<cmd>bp|bd #|buffer %d<cr>", vim.g.buf_num))
    if vim.bo.filetype == 'rust' then
        vim.cmd('silent wa | term cargo test -q')
    elseif vim.bo.filetype == 'go' then
        vim.cmd('silent wa | term gotestsum --format dots-v2')
    elseif vim.bo.filetype == 'cpp' then
        if vim.g.cpptest == nil then
            vim.cmd('silent wa | term cd build && cmake --build ' .. M.get_cpp_what_to_build() .. ' --parallel 8 && ctest --progress --parallel 8')
        else
            vim.cmd('silent wa | term cd build && cmake --build ' .. M.get_cpp_what_to_build() .. ' --parallel 8 && ' .. vim.g.cpptest)
        end
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    elseif vim.bo.filetype == 'c' then
        if vim.g.ctestcmd == nil then
            print("You must first define the ctestcmd variable like this :lua vim.g.ctestcmd = '<binaryToRun>'")
            return
        end
        vim.cmd('silent wa | term ' .. vim.g.ctestcmd)
    elseif vim.bo.filetype == 'javascript' or vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' then
        vim.cmd('silent wa | term npx jest')
    end
end

function M.coverage()
    vim.g.buf_num = vim.fn.bufnr('%')
    vim.keymap.set("n", "<C-e>", string.format("<cmd>bp|bd #|buffer %d<cr>", vim.g.buf_num))
    if vim.bo.filetype == 'go' then
        vim.cmd('term go test -coverprofile cover.out ./... && go tool cover -html cover.out -o cover.html')
    elseif vim.bo.filetype == 'cpp' then
        vim.cmd('!cd build && find . -type f -name "*.gcda" -print0 | xargs -I {} -0 rm -v "{}"')
        vim.cmd('!cd build && ctest --progress --parallel 8')

        vim.cmd('!cd build && lcov -c -d . -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*/test/*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*/.conan/*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*_autogen*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "/usr*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*fmt*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*boost*" -o main_coverage.info')
        vim.cmd('!cd build && lcov -r main_coverage.info "*gtest*" -o main_coverage.info')
        vim.cmd('!cd build && genhtml main_coverage.info --output-directory out')
    end
end
return M
