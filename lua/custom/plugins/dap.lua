local function define_colors()
  vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#b91c1c' })
  vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef' })
  vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bold = true })

  vim.fn.sign_define('DapBreakpoint', {
    text = '🔴',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointCondition', {
    text = '🔴',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapBreakpointRejected', {
    text = '🔘',
    linehl = 'DapBreakpoint',
    numhl = 'DapBreakpoint',
  })
  vim.fn.sign_define('DapStopped', {
    text = '🟢',
    linehl = 'DapStopped',
    numhl = 'DapStopped',
  })
  vim.fn.sign_define('DapLogPoint', {
    text = '🟣',
    linehl = 'DapLogPoint',
    numhl = 'DapLogPoint',
  })
end

local function setup_default_configurations()
  local dap = require 'dap'
  local default_lldb_config = {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    env = {
      DS4_PATH = os.getenv 'DS_PATH',
      DS4_APPLICATION_DIRECTORY = os.getenv 'DS4_APPLICATION_DIRECTORY',
      USAGE_STATISTIC_ACTIVE = os.getenv 'USAGE_STATISTIC_ACTIVE',
      DS_OPENTELEMETRY_TRACES_URL = os.getenv 'DS_OPENTELEMETRY_TRACES_URL',
      DS_OPENTELEMETRY_METRICS_URL = os.getenv 'DS_OPENTELEMETRY_METRICS_URL',
      PGHOST = os.getenv 'PGHOST',
      PGDATABASE = os.getenv 'PGDATABASE',
      PGUSER = os.getenv 'PGUSER',
      PGPASSWORD = os.getenv 'PGPASSWORD',
      DS_UPDATE_ACCEPT_DEV_KEYS = os.getenv 'DS_UPDATE_ACCEPT_DEV_KEYS',
      DS_MFA_SERVER_URL = os.getenv 'DS_MFA_SERVER_URL',
      OPENSSL_MODULES = os.getenv 'OPENSSL_MODULES',
      EASYTI_HOST = os.getenv 'EASYTI_HOST',
      DISABLE_SOLVI_JOB = os.getenv 'DISABLE_SOLVI_JOB',
      DS_WIREGUARD_URL = os.getenv 'DS_WIREGUARD_URL',
      DS_EASYTI_MANAGER_URL = os.getenv 'DS_EASYTI_MANAGER_URL',
      IMPORT_TRANSFER_DISABLE_BACKUP = os.getenv 'IMPORT_TRANSFER_DISABLE_BACKUP',
      IMPORT_TRANSFER_SIMULATE_SHUTDOWN = os.getenv 'IMPORT_TRANSFER_SIMULATE_SHUTDOWN',
      IMPORT_TRANSFER_DISABLE_FACTORY_CHECK = os.getenv 'IMPORT_TRANSFER_DISABLE_FACTORY_CHECK',
      DS_SOLR_URL = os.getenv 'DS_SOLR_URL',
      DS_USE_LOW_AUTH_SECURITY_SETTINGS = os.getenv 'DS_USE_LOW_AUTH_SECURITY_SETTINGS',
      HTML_SANITIZER = os.getenv 'HTML_SANITIZER',
      DS_SKIP_HILFE_INDEX = os.getenv 'DS_SKIP_HILFE_INDEX',
      LICENSE_SERVER_HOST = os.getenv 'LICENSE_SERVER_HOST',
      LICENSE_SETUP_TOKEN = os.getenv 'LICENSE_SETUP_TOKEN',
    },
  }
  local ds4_test_lldb_config = {
    name = 'DS4 Tests',
    type = 'codelldb',
    request = 'launch',
    program = '/home/dev/ds4/ds4/git/build/bin/ds4b-tests-app-ds4',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local test_pattern = vim.fn.input 'Test pattern (--only=): '
      if test_pattern ~= '' then
        return { '--only=' .. test_pattern, '--reporter=singleline' }
      else
        return { '--reporter=singleline' }
      end
    end,
    env = {
      DS4_PATH = os.getenv 'DS_PATH',
      DS4_APPLICATION_DIRECTORY = os.getenv 'DS4_APPLICATION_DIRECTORY',
      USAGE_STATISTIC_ACTIVE = os.getenv 'USAGE_STATISTIC_ACTIVE',
      DS_OPENTELEMETRY_TRACES_URL = os.getenv 'DS_OPENTELEMETRY_TRACES_URL',
      DS_OPENTELEMETRY_METRICS_URL = os.getenv 'DS_OPENTELEMETRY_METRICS_URL',
      PGHOST = os.getenv 'PGHOST',
      PGDATABASE = os.getenv 'PGDATABASE',
      PGUSER = os.getenv 'PGUSER',
      PGPASSWORD = os.getenv 'PGPASSWORD',
      DS_UPDATE_ACCEPT_DEV_KEYS = os.getenv 'DS_UPDATE_ACCEPT_DEV_KEYS',
      DS_MFA_SERVER_URL = os.getenv 'DS_MFA_SERVER_URL',
      OPENSSL_MODULES = os.getenv 'OPENSSL_MODULES',
      EASYTI_HOST = os.getenv 'EASYTI_HOST',
      DISABLE_SOLVI_JOB = os.getenv 'DISABLE_SOLVI_JOB',
      DS_WIREGUARD_URL = os.getenv 'DS_WIREGUARD_URL',
      DS_EASYTI_MANAGER_URL = os.getenv 'DS_EASYTI_MANAGER_URL',
      IMPORT_TRANSFER_DISABLE_BACKUP = os.getenv 'IMPORT_TRANSFER_DISABLE_BACKUP',
      IMPORT_TRANSFER_SIMULATE_SHUTDOWN = os.getenv 'IMPORT_TRANSFER_SIMULATE_SHUTDOWN',
      IMPORT_TRANSFER_DISABLE_FACTORY_CHECK = os.getenv 'IMPORT_TRANSFER_DISABLE_FACTORY_CHECK',
      DS_SOLR_URL = os.getenv 'DS_SOLR_URL',
      DS_USE_LOW_AUTH_SECURITY_SETTINGS = os.getenv 'DS_USE_LOW_AUTH_SECURITY_SETTINGS',
      HTML_SANITIZER = os.getenv 'HTML_SANITIZER',
      DS_SKIP_HILFE_INDEX = os.getenv 'DS_SKIP_HILFE_INDEX',
      LICENSE_SERVER_HOST = os.getenv 'LICENSE_SERVER_HOST',
      LICENSE_SETUP_TOKEN = os.getenv 'LICENSE_SETUP_TOKEN',
    },
    -- preLaunchTask = function()
    --     local command = "resetTest"
    --     vim.fn.system(command)
    -- end,
  }

  dap.configurations.c = default_lldb_config
  dap.configurations.cpp = { default_lldb_config, ds4_test_lldb_config }
  dap.configurations.rust = default_lldb_config
  dap.configurations.asm = default_lldb_config
end

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'nvim-telescope/telescope-dap.nvim',
      config = function()
        require('telescope').load_extension 'dap'
      end,
    },
    {
      'rcarriga/nvim-dap-ui',
      types = true,
    },
    'nvim-neotest/nvim-nio',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        enabled = true,
      },
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- dapui setup
    dapui.setup {
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.25 },
            { id = 'console', size = 0.75 },
          },
          position = 'bottom',
          size = 30,
        },
      },
      mappings = {
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 's',
        repl = 'r',
        toggle = 't',
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
      -- require('edgy').close()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end

    -- dap.listeners.before.event_exited['dapui_config'] = function()
    --   dapui.close()
    -- end

    define_colors()
    vim.keymap.set('n', '<F6>', function()
      dap.step_over()
    end)
    vim.keymap.set('n', '<F7>', function()
      dap.step_into()
    end)
    vim.keymap.set('n', '<F8>', function()
      dap.step_out()
    end)
    vim.keymap.set('n', '<leader>b', function()
      dap.toggle_breakpoint()
    end)
    vim.keymap.set('n', '<F10>', function()
      dap.terminate()
    end)

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = vim.fn.stdpath 'data' .. '/mason/packages/codelldb/extension/adapter/codelldb',
        args = { '--port', '${port}' },
      },
    }

    vim.keymap.set('n', '<F5>', function()
      setup_default_configurations()
      -- when debug is called firstly try to read and/or update launch.json configuration
      -- from the local project which will override all the default configurations
      -- if vim.fn.filereadable '.vscode/launch.json' then
      --   require('dap.ext.vscode').load_launchjs(nil, { lldb = { 'rust', 'c', 'cpp' } })
      -- else
      -- If not possible stick to the default prebuilt configurations
      setup_default_configurations()
      -- end

      require('dap').continue()
    end)

    -- Keymaps
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle [b]reakpoint' })
    vim.keymap.set('n', '<leader>gb', dap.run_to_cursor, { desc = 'Run to cursor' })
    vim.keymap.set('n', '<leader>gp', dap.up, { desc = '[G]o stack u[p]' })
    vim.keymap.set('n', '<leader>gn', dap.down, { desc = '[G]o stack dow[n]' })
    vim.keymap.set('n', '<space>?', function()
      require('dapui').eval(nil, { enter = true })
    end)
    -- vim.keymap.set('n', '<F1>', dap.continue)
    -- vim.keymap.set('n', '<F2>', dap.step_into)
    -- vim.keymap.set('n', '<F3>', dap.step_over)
    -- vim.keymap.set('n', '<F4>', dap.step_out)
    -- vim.keymap.set('n', '<F5>', dap.step_back)
    -- vim.keymap.set('n', '<F7>', dap.restart)

    -- Additional helpful keymaps
    vim.keymap.set('n', '<leader>td', dapui.toggle, { desc = '[T]oggle [D]ebug UI' })
    vim.keymap.set('n', '<leader>dx', function()
      dap.terminate()
      dapui.close()
    end, { desc = '[D]ebug Stop/[X]it' })
  end,
}
