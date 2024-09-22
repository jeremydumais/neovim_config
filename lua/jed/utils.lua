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

function M.set_executable(exe_name)
    vim.g.executable_name = exe_name
    print("Executable is now set to " .. exe_name)
end

function M.set_args(args)
    local args_str = table.concat(args, " ")
    vim.g.runargs = args_str
    print("Run args are not set to :" .. args_str)
end

function M.clear_args()
    vim.g.runargs = nil
    print("Run args are now cleared")
end

function M.get_cpp_what_to_build()
    local what_to_build = '.'
    if vim.g.projectbuild ~= nil then
        what_to_build = vim.g.projectbuild
    end
    return what_to_build
end

function M.hasMakefile()
    -- The path to the Makefile; adjust if you need to check in a specific directory
    local makefilePath = vim.fn.getcwd() .. "/Makefile"
    -- Attempt to open the Makefile for reading
    local file = io.open(makefilePath, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

function M.run()
    vim.g.buf_num = vim.fn.bufnr('%')
    vim.keymap.set("n", "<C-e>", string.format("<cmd>bp|bd #|buffer %d<cr>", vim.g.buf_num))
    if vim.bo.filetype == 'rust' then
        vim.cmd('silent wa | term cargo run')
    elseif vim.bo.filetype == 'go' then
        local goargs = ''
        if vim.g.runargs ~= nil then
            goargs = vim.g.runargs
        end
        vim.cmd('silent wa | term go build && go run . ' .. goargs)
    elseif vim.bo.filetype == 'cpp' then
        if vim.g.cpprun == nil then
            print("You must first define the cpprun variable like this :lua vim.g.cpprun = '<binaryToRun>'")
            return
        end
        vim.cmd('silent wa | term cd build && cmake --build '
            .. M.get_cpp_what_to_build()
            ..' --parallel 8 && ./'
            .. vim.g.cpprun)
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    elseif ((vim.bo.filetype == 'c' or vim.bo.filetype == 'h') and M.hasMakefile())
            or vim.bo.filetype == 'make' then
        if vim.g.executable_name == nil then
            print("You must first set the executable name with the SetExecutable command")
            return
        end
        vim.cmd('silent wa | term ./'
            .. vim.g.executable_name)
    elseif (vim.bo.filetype == 'ps1') then
        vim.cmd('silent wa | term pwsh '
            .. vim.api.nvim_buf_get_name(0))
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
    elseif ((vim.bo.filetype == 'c' or vim.bo.filetype == 'h') and M.hasMakefile())
            or vim.bo.filetype == 'make' then
        vim.cmd('silent wa | term make')
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
            vim.cmd('silent wa | term cd build && cmake --build '
                .. M.get_cpp_what_to_build()
                .. ' --parallel 8 && ctest --progress --parallel 8')
        else
            vim.cmd('silent wa | term cd build && cmake --build '
            .. M.get_cpp_what_to_build()
            .. ' --parallel 8 && '
            .. vim.g.cpptest)
        end
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    elseif ((vim.bo.filetype == 'c' or vim.bo.filetype == 'h') and M.hasMakefile())
            or vim.bo.filetype == 'make' then
        vim.cmd('silent wa | term make test')
        local current_window = vim.api.nvim_get_current_win()
        local last_line = vim.api.nvim_buf_line_count(0)
        vim.api.nvim_win_set_cursor(current_window, {last_line, 0})
    elseif vim.bo.filetype == 'c' then
        if vim.g.ctestcmd == nil then
            print("You must first define the ctestcmd variable like this :lua vim.g.ctestcmd = '<binaryToRun>'")
            return
        end
        vim.cmd('silent wa | term ' .. vim.g.ctestcmd)
    elseif vim.bo.filetype == 'javascript'
            or vim.bo.filetype == 'typescript'
            or vim.bo.filetype == 'typescriptreact' then
        vim.cmd('silent wa | term npx jest')
    elseif vim.bo.filetype == 'ps1' then
        vim.cmd('silent wa | term pwsh -Command "Invoke-Pester"')
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
