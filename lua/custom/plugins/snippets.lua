return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local ls = require 'luasnip'
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.setup {}

    ls.add_snippets('cpp', {
      s('lf', {
        t '[&](const auto& ',
        i(1, 'obj'),
        t ') {',
        t { '', '\t' },
        i(2, '// code here'),
        t { '', '}' },
      }),
    })
  end,
}
