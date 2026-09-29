# dotfiles

Manually copy and paste home and other dot files

Added homebrew paths to .zshrc

After installing iterm2, had to manually set the new default profile.

Brew didn't install at first, using a different curl. It requires a sudo.`


1. TODO: Add args for scripts to point to other language configurations. For example Java configuration. Needed installs, .zshrc changes, and nvim/init.vim file changes
1. TODO: Script move .files over
1. TODO: Move iterm json profile over
1. TODO: Set iterm profile to default
1. TODO: Set iterm font to hacker mono regular 18 size
1. FIXED: Plugin install is now automated in `3_nvim_plugins.sh`, which runs `nvim --headless "+PlugInstall --sync" +UpdateRemotePlugins +qall` after `2_home.sh` has copied `init.vim` into place (previously `1_setup.sh` ran `PlugInstall` before init.vim existed, so the command wasn't defined yet). `cmake` and `tree-sitter-cli` are now brew-installed in `1_setup.sh` since `telescope-fzf-native.nvim` and `nvim-treesitter` need them to build/compile parsers.
1. FIXED: `coq.lsp_ensure_capabilities` was indexing a nil global (`require "coq"` was never assigned to a variable) — added `local coq = require("coq")` before use.
1. FIXED: `nvim-treesitter`'s unpinned `main` branch pulled a full incompatible rewrite that dropped `require('nvim-treesitter.configs').setup{}`. Migrated `init.vim` to the new API (`require('nvim-treesitter').install{...}` plus a `FileType` autocmd calling `vim.treesitter.start()`/setting `indentexpr`).
1. TODO: will need to restart machine for KeyRepeat to work it seems
1. TODO: Was having issues with the python3 pathing between machines. `/usr/local/bin` vs `/usr/bin`. Set it in my init file to point correctly on this machine. 

