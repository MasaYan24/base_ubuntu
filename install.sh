#!/bin/sh

# install applications
sudo apt install -y build-essential g++ gcc libglvnd-dev libfuse2 make pkg-config  # 開発ツール  
sudo apt install -y cifs-utils direnv file procps unzip  # システム管理・ユーティリティ
sudo apt install -y keychain openssh-server tmux zsh  # シェル・リモート
sudo apt install -y imagemagick neovim curl git ruby wget xclip # エディタ・画像処理・一般ツール・言語

sudo chsh -s $(which zsh)  $(whoami)

# install homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Neovim install and setting
# sudo apt install -y neovim
# git clone https://github.com/MasaYan24/.vim.git $HOME/
# sh $HOME/.vim/install.sh

## Prompto setting
brew install starship
mkdir -p $HOME/.config && echo "command_timeout = 2000" > $HOME/.config/starship.toml
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
wget https://raw.githubusercontent.com/MasaYan24/zshrc/main/.zshrc -P $HOME/

## Developing tool
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  -O /tmp/miniconda.sh \
  && sh /tmp/miniconda.sh -b -p $HOME/miniconda

## git setting
git config --global core.editor nano
git config --global mergetool.prompt false
git config --global credential.helper "cache --timeout 604800"
git config --global core.pager "LESSCHARSET=utf-8 less"

## Python formatter
conda activate base
pip install black isort flake8 autopep8

# Update all
sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y

# reboot
read -p "reboot? [y/N]: " answer
case "$answer" in
    [yY][eE][sS]|[yY])
        echo "Rebooting..."
        sudo reboot;;
    *)
        echo "System reboot recommended.";;
esac
