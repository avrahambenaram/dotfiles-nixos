function os.capture(cmd, raw)
 local f = assert(io.popen(cmd, 'r'))
 local s = assert(f:read('*a'))
 f:close()
 if raw then return s end
 s = string.gsub(s, '^%s+', '')
 s = string.gsub(s, '%s+$', '')
 s = string.gsub(s, '[\n\r]+', ' ')
 return s
end

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})

  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'csharp_ls',
		'docker_compose_language_service',
		'dockerls',
		'eslint',
		'lua_ls',
		'omnisharp',
		'rust_analyzer',
		'tailwindcss',
		'tsserver',
		'prismals',
	},
	handlers = {
		lsp.default_setup,
	},
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero
-- mapping for enter confirm selection
-- LSPKind in formatting

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-k>'] = cmp.mapping.select_prev_item(),
	['<C-j>'] = cmp.mapping.select_next_item(),
	['<Tab>'] = function() end
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
})

-- C#
local pid = vim.fn.getpid()
local omnisharp_bin = os.capture("which OmniSharp")
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
	on_attach = function(client)
      -- other on_attach code
      require'formatter'.setup({
        filetype = {
          csharp = {
            -- formatter setup
          }
        }
      })
    end
}
