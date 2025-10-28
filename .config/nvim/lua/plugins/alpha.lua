return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local logo = [[
     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.header.opts.hl = "AlphaHeader" -- Cor para o logo

    dashboard.section.buttons.val = {
      dashboard.button("n", "  Novo arquivo", "<cmd> ene <BAR> startinsert <cr>"),
      dashboard.button("r", "  Arquivos recentes", "<cmd> lua LazyVim.pick('oldfiles')() <cr>"),
      dashboard.button("c", "  Configuração", "<cmd> lua LazyVim.pick.config_files()() <cr>"),
      dashboard.button("x", "  Plugins", "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰋣  Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", "  Sair", "<cmd> qa <cr>"),
    }
    dashboard.section.buttons.opts = {
      spacing = 2,
      position = "center",
      width = 50,
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      button.opts.width = 50
    end
    dashboard.section.buttons.opts.hl = "AlphaButtons"

    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 2
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end
    require("alpha").setup(dashboard.opts)
  end,
}
