-- ============================================================================
-- GitHub Copilot Configuration
-- Full AI-powered code completion with model selection
-- ============================================================================

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""

      -- Enable Copilot for all filetypes
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }
    end,
  },

  -- Copilot Chat - AI assistant for code
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    config = function()
      require("CopilotChat").setup({
        debug = false,
        show_help = "yes",
        prompts = {
          Explain = "Explain how this code works.",
          Review = "Review this code and provide concise suggestions.",
          Tests = "Generate tests for this code.",
          Refactor = "Refactor this code to improve its clarity and readability.",
          FixCode = "Fix the bugs in this code.",
          BetterNamings = "Improve variable and function names.",
          Documentation = "Add documentation comments to this code.",
          SwaggerApiDocs = "Generate Swagger API documentation.",
          SwaggerJsDocs = "Generate JSDoc comments.",
          Optimize = "Optimize this code for performance.",
          Explain_Rust = "Explain this Rust code with focus on ownership and borrowing.",
          Explain_Assembly = "Explain this assembly code with register and memory details.",
        },
        auto_follow_cursor = true,
        window = {
          layout = "float",
          relative = "editor",
          width = 0.8,
          height = 0.8,
          row = 2,
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<Tab>",
          },
          close = {
            normal = "q",
            insert = "<C-c>",
          },
          reset = {
            normal = "<C-r>",
            insert = "<C-r>",
          },
          submit_prompt = {
            normal = "<CR>",
            insert = "<C-s>",
          },
          accept_diff = {
            normal = "<C-y>",
            insert = "<C-y>",
          },
          yank_diff = {
            normal = "gy",
          },
          show_diff = {
            normal = "gd",
          },
          show_system_prompt = {
            normal = "gp",
          },
          show_user_selection = {
            normal = "gs",
          },
        },
      })

      -- Model selection command
      vim.api.nvim_create_user_command("CopilotChatModels", function()
        local models = {
          "gpt-4",
          "gpt-4-turbo",
          "gpt-3.5-turbo",
          "claude-3-opus",
          "claude-3-sonnet",
        }

        vim.ui.select(models, {
          prompt = "Select Copilot Model:",
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            vim.g.copilot_model = choice
            print("Copilot model set to: " .. choice)
          end
        end)
      end, {})
    end,
  },
}
