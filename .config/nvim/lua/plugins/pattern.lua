return {
  {
    'haya14busa/vim-asterisk',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
      keys = {
        {
          'n',
          [[<Cmd>execute 'normal!' v:count1 .. 'n'<CR><Cmd>lua require('hlslens').start()<CR>]],
          { silent = true },
        },
        {
          'N',
          [[<Cmd>execute 'normal!' v:count1 .. 'N'<CR><Cmd>lua require('hlslens').start()<CR>]],
          { silent = true },
        },
      },
      config = true,
    },
    keys = {
      {
        '*',
        [[<Plug>(asterisk-*)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        '#',
        [[<Plug>(asterisk-#)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'g*',
        [[<Plug>(asterisk-g*)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'g#',
        [[<Plug>(asterisk-g#)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'z*',
        [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'gz*',
        [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'z#',
        [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
      {
        'gz#',
        [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]],
        mode = { 'n', 'v', 'o' },
        { silent = true },
      },
    },
  },
}
