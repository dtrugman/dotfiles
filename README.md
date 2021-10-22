# Installation steps:

```
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
printf '\n[[ -s "$HOME/.homesick/repos/homeshick/homeshick.sh" ]] && source "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

homeshick clone git@github.com:dtrugman/dotfiles.git

printf '\n[[ -s "$HOME/.bash_config" ]] && source "$HOME/.bash_config"' >> $HOME/.bashrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c 'PlugInstall'
```
