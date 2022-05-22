-- LSP config for servers installed with nvim-lsp-installer
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {
        capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    }
    server:setup(opts)
end)

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
