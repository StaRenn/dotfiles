local M = {}
local map = vim.keymap.set

local servers = { "html", "cssls", "eslint", "stylelint_lsp", "cssmodules_ls" }

local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterStylesDTS(value)
  return string.match(value.targetUri, "styles.d.ts") == nil
end

local function filterReactDTS(value)
  return string.match(value.targetUri, "react/index.d.ts") == nil
end

local function applyFilters(value)
  return filterStylesDTS(value) and filterReactDTS(value)
end

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if vim.fn.has "nvim-0.11" ~= 1 then
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
    if client:supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  dofile(vim.g.base46_cache .. "lsp")
  require("nvchad.lsp").diagnostic_config()

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      M.on_attach(_, args.buf)
    end,
  })

  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init, on_attach = M.on_attach })
  
  for _, lsp in ipairs(servers) do 
    vim.lsp.enable(lsp)
  end

  -- ts_ls with definition filters
  vim.lsp.config("ts_ls", {
    handlers = {
      ["textDocument/definition"] = function(err, result, method, ...)
        if vim.tbl_islist(result) then
          local filtered_result = filter(result, applyFilters)
          return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
        end

        vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
      end,
    },
  })

  vim.lsp.enable("ts_ls")

  -- rust_analyzer
  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {
        imports = {
          granularity = { group = "module" },
          prefix = "self",
        },
        cargo = {
          buildScripts = { enable = true },
        },
        procMacro = { enable = true },
      },
    },
  })

  vim.lsp.enable("rust_analyzer")

  -- jsonls with schemas
  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "manifest.json", "manifest.webmanifest" },
            url = "https://json.schemastore.org/web-manifest-combined.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { ".eslintrc", ".eslintrc.json" },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            fileMatch = { "now.json", "vercel.json" },
            url = "https://json.schemastore.org/now.json",
          },
          {
            fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
            url = "http://json.schemastore.org/stylelintrc.json",
          },
        },
      },
    },
  })

  vim.lsp.enable("jsonls")

  -- lua_ls
  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          library = {
            vim.fn.expand "$VIMRUNTIME/lua",
            vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            "${3rd}/luv/library",
          },
        },
      },
    },
  })
  vim.lsp.enable "lua_ls"
end

return M
