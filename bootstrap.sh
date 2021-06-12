# 安装 rg
brew install ripgrep
brew install tmux

# 安装字体

# 设置软连接兼容 neovim
ln -sf ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vimrc ~/.vim/init.vim
ln -s ~/.vim ~/.config/nvim

# 安装 vim 插件
vim +PlugInstall +qall
