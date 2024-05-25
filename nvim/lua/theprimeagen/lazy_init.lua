local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "theprimeagen.lazy",
  change_detection = { notify = false },
})

vim.api.nvim_command("command! ClangFormat execute 'silent !clang-format -i %' | edit!")

vim.api.nvim_exec(
  [[
  augroup fmt
    autocmd!
    autocmd BufWritePre *.c,*.cpp,*.h,*.hpp,*.m,*.mm execute 'silent !clang-format -i %'
    autocmd BufWritePre *.c,*.cpp,*.h,*.hpp,*.m,*.mm silent! write
  augroup END
]],
  false
)
