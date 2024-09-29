require("cypher1")

-- Add tako's tree-sitter parser
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tako = {
  install_info = {
    url = "/home/jaypratt/Code/tako/tree-sitter-tako/", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "tk", -- if filetype does not match the parser name
}

vim.treesitter.language.register('tako', 'tako')
vim.treesitter.language.register('tako', 'tk')
