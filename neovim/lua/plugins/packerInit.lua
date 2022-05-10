-- mostly taken from https://github.com/NvChad/NvChad/blob/main/lua/plugins/packerInit.lua (I'm also using GPLv3 so shouldn't be a problem)
local vim = vim

pcall(vim.cmd, 'packadd packer.nvim')

local present, packer = pcall(require, 'packer')

local was_present = true
if not present then
    was_present = false
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    vim.fn.delete(packer_path, 'rf')
    vim.fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    }

    pcall(vim.cmd, 'packadd packer.nvim')

    present, packer = pcall(require, 'packer')
    if not present then
        error("Couldn't clone packer to '" .. install_path("'. Reason: ") .. packer)
    end
end

packer.init {
    display = {
        open_fn = require('packer.util').float,
    },
}

return packer, was_present
