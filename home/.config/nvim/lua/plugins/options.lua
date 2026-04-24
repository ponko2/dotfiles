return {
  {
    'ciaranm/securemodelines',
    config = function()
      vim.opt.modelines = 0
      vim.opt.modeline = false
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gitsigns.nav_hunk('next', { target = 'all' })
          end
        end, { desc = 'Next hunk' })
        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gitsigns.nav_hunk('prev', { target = 'all' })
          end
        end, { desc = 'Previous hunk' })

        -- Actions
        map('n', '<Leader>hs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<Leader>hr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        map('v', '<Leader>hs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Stage hunk' })
        map('v', '<Leader>hr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Reset hunk' })
        map('n', '<Leader>hS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<Leader>hR', gitsigns.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<Leader>hp', gitsigns.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<Leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })
        map('n', '<Leader>hb', function()
          gitsigns.blame_line({ full = true })
        end, { desc = 'Blame line' })
        map('n', '<Leader>hd', gitsigns.diffthis, { desc = 'Diff against the index' })
        map('n', '<Leader>hD', function()
          gitsigns.diffthis('~')
        end, { desc = 'Diff against the ~' })
        map('n', '<Leader>hQ', function()
          gitsigns.setqflist('all')
        end, { desc = 'Set quickfix list for all' })
        map('n', '<Leader>hq', gitsigns.setqflist, { desc = 'Set quickfix list' })

        -- Toggles
        map(
          'n',
          '<Leader>tb',
          gitsigns.toggle_current_line_blame,
          { desc = 'Toggle current line blame' }
        )
        map('n', '<Leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
      end,
    },
  },
  {
    'nathanaelkane/vim-indent-guides',
    cond = not vim.g.vscode,
    init = function()
      vim.g.indent_guides_enable_on_vim_startup = 1
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    cond = not vim.g.vscode,
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = {
      options = {
        theme = 'gruvbox_dark',
        section_separators = '',
        component_separators = '',
      },
    },
  },
  {
    'rbtnn/vim-ambiwidth',
    init = function()
      vim.g.ambiwidth_add_list = {
        { 0x00B7, 0x00B7, 2 },
        { 0x2018, 0x2019, 2 },
        { 0x201c, 0x201d, 2 },
        { 0x2025, 0x2026, 2 },
      }
      vim.g.ambiwidth_cica_enabled = false
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      chunk = {
        enable = true,
      },
    },
  },
}
