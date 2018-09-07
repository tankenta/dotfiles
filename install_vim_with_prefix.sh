#!/bin/bash
PREFIX=$HOME/local

mkdir -p $PREFIX/build
cd $PREFIX/build
git clone https://github.com/vim/vim.git

cd vim
./configure --enable-multibyte --with-features=huge --disable-selinux --prefix=$HOME/local --enable-luainterp=yes --enable-rubyinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes --enable-fail-if-missing > ../configure_result.log

# make && make install
