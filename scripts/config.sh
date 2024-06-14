dir=$1
cp -r $dir/dotfiles/nvim $dir/.config
cp -r $dir/dotfiles/i3 $dir/.config
cp -r $dir/dotfiles/xfce4 $dir/.config
cp -r $dir/dotfiles/alacritty $dir/.config
cp -r $dir/dotfiles/wallpaper /usr/share/images
echo "alias vim="nvim"" >> $dir/.bashrc
source $dir/.bashrc
