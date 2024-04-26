curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
source ~/.bashrc
nvm install node


#Create dirs and config files
mkdir -p $HOME/.config mkdir -p $HOME/.config/nvim; mkdir -p $HOME/.config/nvim/plugged;
touch --no-create $HOME/.config/nvim/init.vim

cat ./init.vim > $HOME/.config/nvim/init.vim

#Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
