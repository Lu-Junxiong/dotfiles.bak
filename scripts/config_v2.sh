dir=$1
ln -s $dir/dotfiles/nvim $dir/.config
ln -s $dir/dotfiles/i3 $dir/.config
ln -s $dir/dotfiles/xfce4 $dir/.config
ln -s $dir/dotfiles/alacritty $dir/.config
ln -s $dir/dotfiles/wallpaper /usr/share/images
echo "alias vim="nvim"" >> $dir/.bashrc
source $dir/.bashrc
