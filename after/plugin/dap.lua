local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000 -- 💀 Use the port printed out or specified with `--port`
}

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/home/jed/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {
        "--test-threads",
        "1",
    },
  },
}

require("dapui").setup()

vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<F29>", "<Cmd>lua require'dap'.terminate()<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")
vim.keymap.set("n", "<Leader>df", "<Cmd>lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<Leader>k", "<cmd>lua require('dapui').eval()<cr>")

