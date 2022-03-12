require('telescope').setup{
  defaults = {
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    generic_sorter =  require'telescope.sorters'.get_fzy_sorter,
  }
}
require("telescope").load_extension "file_browser"
