local actions = require("fzf-lua").actions

require("fzf-lua").setup({
    fzf_opts = {
        ["--layout"] = "default",
    },
    helptags = {
        actions = {
            ["enter"] = actions.help_curwin,
        },
    },
    files = {
        fd_opts = "--color=never "
            .. "--type f "
            .. "--hidden "
            .. "--no-ignore-vcs "
            .. "--follow "
            .. "",
    },
    grep = {
        rg_opts = "--hidden "
            .. "--column "
            .. "--color=always "
            .. "--smart-case "
            .. "--no-ignore-vcs "
            .. "--line-number"
            .. "",
    },
    winopts = {
        height = 0.80,
        width = 0.90,
        preview = {
            layout = "horizontal",
            vertical = "up:60%",
            horizontal = "right:50%",
        },
    },
    actions = {
        files = {
            -- instead of the default action 'actions.file_edit_or_qf' it's important to
            -- define all other actions here as this table does not get merged with the
            -- global defaults
            ["enter"] = actions.file_edit,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["alt-q"] = actions.file_sel_to_qf,
        },
    },
})
