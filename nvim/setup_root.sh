curl -sL https://deb.nodesource.com/setup_20.x | sudo bash -
sudo apt install exuberant-ctags neovim nodejs -y

#for root

#Install VimPlug
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#sudo mkdir -p /root/.config; sudo mkdir -p /root/.config/nvim; sudo mkdir -p /root/.config/nvim/plugged;
#sudo touch --no-create /root/.config/nvim/init.vim

#cat ./nvim.sh >> /root/.config/nvim/init.vim


#Create dirs and config files
mkdir -p $HOME/.config mkdir -p $HOME/.config/nvim; mkdir -p $HOME/.config/nvim/plugged;
touch --no-create $HOME/.config/nvim/init.vim

cat ./nvim.sh >> $HOME/.config/nvim/init.vim

#Install VimPlug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
