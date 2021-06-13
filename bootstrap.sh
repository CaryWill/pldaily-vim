# 安装 rg
brew install ripgrep
brew install tmux

<<<<<<< HEAD
=======
# 安装字体

>>>>>>> 87c9b0b1a60d3fa41cfc6e290037e8e6fc0730f6
# 设置软连接兼容 neovim
ln -sf ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vimrc ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim

# 安装 vim 插件
vim +PlugInstall +qall
