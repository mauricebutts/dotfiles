# Installs all vim-plug managed Neovim plugins headlessly.
# Must run after 2_home.sh, since :PlugInstall only exists once
# ~/.config/nvim/init.vim (with plug#begin/plug#end) is in place.

echo "Installing Neovim plugins..."
nvim --headless "+PlugInstall --sync" +UpdateRemotePlugins +qall
echo "Neovim plugins installed."
