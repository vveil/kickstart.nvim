return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    lazy = false,
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          javascript = true, -- allow specific filetype
          typescript = true, -- allow specific filetype
          cpp = true, -- allow specific filetype
          hpp = true, -- allow specific filetype
          ['*'] = false, -- disable for all other filetypes and ignore default `filetypes`
        },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- model = 'Llama-3.3-70B-Instruct',
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
