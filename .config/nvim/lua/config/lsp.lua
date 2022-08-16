
----------------------------------------------------------------------------------------------------------------------
--                                          NVIM LSP package manager Mason                                          --
----------------------------------------------------------------------------------------------------------------------
require("mason").setup({
    -- Mason package manager settings go here
})
require("mason-lspconfig").setup({
    -- Mason + LspConfig bridge settings go here
    ensure_installed = { "pyright", "clangd" }
})
require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    --["rust_analyzer"] = function ()
    --    require("rust-tools").setup {}
    --end
}

----------------------------------------------------------------------------------------------------------------------
--                                            Custom LSP configurations                                             --
----------------------------------------------------------------------------------------------------------------------

-- VHDL Language server with VHDL-Tool
local server_name = 'vhdl_tool'
local configs = require 'lspconfig.configs'
if configs[server_name] == nil then
    local util = require 'lspconfig.util'
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    configs[server_name] = {
        default_config = {
            cmd = {'vhdl-tool', 'lsp'};
            filetypes = {'vhdl'};
            root_dir = util.root_pattern('vhdltool-config.yaml', '.git');
            settings = {};
        }
    }
    require'lspconfig'.vhdl_tool.setup{ capabilities = capabilities }
end

