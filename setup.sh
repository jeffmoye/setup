#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14.04 LTS EC2 instance
# for headless setup. 

# update apt and install git and curl
echo "~~~~~~~~~~~~~~~~~~~~setup.sh~~~~~~~~~~~~~~~~~~~~"
echo [Firstly, update apt-get]
sudo apt-get update

echo [Install git...]
sudo apt-get install -y git

echo [Install curl...]
sudo apt-get install -y curl

# Install nvm: node-version manager
# https://github.com/creationix/nvm
echo [Install nvm...]
git clone https://github.com/creationix/nvm.git ~/.nvm

# Load nvm 
echo [Load nvm...]
source $HOME/.nvm/nvm.sh
# ...and install a version of node
# (the original script loaded the latest version, which
# was v0.10.12 at the time)). But we'll get the list
# of installable versions and pick the last (which will
# be the most recent)
echo [Install node...]
echo [The avaliable versions are...]
nvm ls-remote
# Pick a version to install.
# Remember to change this version in dotfiles/.bashrc too!
NODE_VER=v0.11.13
echo [Version to install = $NODE_VER...]
nvm install $NODE_VER
nvm use $NODE_VER

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
echo [Install jshint...]
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
echo [Install rlwrap...]
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
echo [Install emacs...]
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
echo [Install heroku toolbelt...]
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# git pull and install dotfiles as well
echo [Setup dotfiles....]
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/jeffmoye/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

echo "~~~~~~~~~~~~~~~setup.sh complete~~~~~~~~~~~~~~~~"
