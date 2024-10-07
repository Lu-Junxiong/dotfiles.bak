return {{
    "L3MON4D3/LuaSnip",
    event = {"InsertEnter"},
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
        require("luasnip").config.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true
        })
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        local fmt = require("luasnip.extras.fmt").fmt
        ls.add_snippets("python", {
            s("main", {
                t("if __name__ == '__main__':"),
                t({"", "\t"}),
                i(1, "# TODO: write code")
            }),
            s("print", fmt([[print("{}")]], { i(1, ' ') })),
        })
    end,
    dependencies = {{'saadparwaiz1/cmp_luasnip'}}
}}
