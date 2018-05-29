#!/bin/sh
sudo apt-get update
sudo apt-get upgrade

# for using tty1
sudo sed -i -e 's/#GRUB_TERMINAL/GRUB_TERMINAL/g' /etc/default/grub
sudo update-grub2

sudo apt-get install xinit gnome fcitx fcitx-mozc git firefox vim vim-gtk nemo xinput xmonad

sudo apt-get purge ibus
sudo apt-get autoremove

# set Nemo as Default File manager
xdg-mime default nemo.desktop inode/directory application/x-gnome-saced-search

sudo apt-get install fonts-takao-pgothic fonts-takao-gothic fonts-takao-mincho
sudo apt-get install chromium-browser chromium-browser-l10n

# add-apt-repository
sudo apt-get install software-properties-common

# dotfiles
git clone https://github.com/tankenta/dotfiles.git

# git
git config --global user.email "hkenta112@gmail.com"
git config --global user.name "tankenta"

# common tools
sudo apt-get install build-essential checkinstall

# pyenv (without sudo)
git clone git://github.com/yyuu/pyenv.git ~/.pyenv
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc 
# echo 'eval "$(pyenv init -)"' >> ~/.bashrc 
# echo 'alias activate="source $PYENV_ROOT/versions/miniconda3-4.3.30/bin/activate"' >> ~/.bashrc
# echo 'alias deactivate="source $PYENV_ROOT/versions/miniconda3-4.3.30/bin/deactivate"' >> ~/.bashrc
source ~/.bashrc
pyenv install miniconda3-4.3.30
pyenv rehash
pyenv global miniconda3-4.3.30
conda update conda
conda config --add channels conda-forge
conda install matplotlib numpy opencv ipython

# python
# sudo apt-get install python-pip python-dev
# numpy
# sudo pip install numpy
# matplotlib
# sudo pip install matplotlib
# opencv
# sudo apt-get install libopencv-dev
# sudo apt-get install python-opencv

# OpenGL version checker (glxinfo)
sudo apt-get install mesa-utils
# glfw
sudo apt-get install libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev

# node npm
sudo apt-get install -y nodejs npm
sudo npm cache clean
sudo npm install -g n
sudo n stable
sudo ln -sf /usr/local/bin/node /usr/bin/node
sudo apt-get purge -y nodejs npm

# phantomjs
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
bzip2 -dc phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar xvf -
sudo cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin

# markdown2pdf
sudo npm install -g markdown2pdf

# Download slack
sudo dpkg -i slack-desktop-*.deb

# LibreOffice
sudo add-apt-repository ppa:libreoffice/ppa
sudo apt-get update && sudo apt-get install libreoffice

# firefox flash player
sudo apt-add-repository ppa:nilarimogard/webupd8
sudo apt-get install freshplayerplugin
sudo apt-get install pepperflashplugin-nonfree
sudo update-pepperflashplugin-nonfree --install

# image editer: fotoxx
sudo apt-get install fotoxx
# or pinta
sudo apt-get install pinta

# winehq-devel (2.0 or later)
# http://tipsonubuntu.com/2017/07/23/wine-2-13-released-install-ubuntu/
# https://www.winehq.org/pipermail/wine-devel/2017-March/117104.html
sudo dpkg --add-architecture i386
wget https://dl.winehq.org/wine-builds/Release.key && sudo apt-key add Release.key
sudo add-apt-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
sudo apt-get update
sudo apt-get install --install-recommends winehq-devel
sudo apt-get install p11-kit:i386 libp11-kit-gnome-keyring:i386 
sudo apt-get install wine-mono0.0.8 wine-gecko2.21 cabextract
wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
mv  winetricks ~/local/bin/
winetricks allfonts
winecfg
## uninstall
sudo apt-get remove --autoremove winehq-devel

# ffmpeg
git clone https://github.com/takiyu/dotfiles.git
./dotfiles/opencv/ubuntu14.04/install_ffmpeg.sh

# video player: mpv
# sudo apt-get install devscripts equivs
wget https://github.com/libass/libass/releases/download/0.13.6/libass-0.13.6.tar.xz
tar Jxvf libass-0.13.6.tar.xz
rm libass-0.13.6.tar.xz
cd libass-0.13.6
./configure --prefix=/usr && make
sudo make install
# ./libtool --finish /usr/local/lib
wget https://github.com/mpv-player/mpv/archive/v0.24.0.tar.gz
tar xzvf v.0.24.tar.gz
rm v.0.24.tar.gz
cd mpv-0.24.0
./waf configure
./waf build
sudo ./waf install
sudo pip install youtube-dl
# shared library
sudo vi -u NONE /etc/ld.so.conf.d
## add
# /home/tanke/ffmpeg/libavcodec
# /home/tanke/ffmpeg/libavutil
# /home/tanke/ffmpeg/libavformat
# /home/tanke/ffmpeg/libavdevice
# /home/tanke/ffmpeg/libavfilter
# /home/tanke/ffmpeg/libswscale
# /home/tanke/ffmpeg/libswresample
# /home/tanke/ffmpeg/libpostproc
sudo ldconfig
ldd `which mpv` | grep not
## manual
# https://mpv.io/manual/master/

# bluetooth headphone
sudo apt-get install pulseaudio-module-bluetooth

# Arduino CLI tools
git clone https://github.com/platformio/platformio.git
sudo cp ./platformio/script/99-platformio-udev.rules /etc/udev/rules.d/
pip install platformio
pip install --egg scons

# selenium-firefox
wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
tar xzvf geckodriver-v0.18.0-linux64.tar.gz
rm geckodriver-v0.18.0-linux64.tar.gz
mv geckodriver ~/local/bin/
