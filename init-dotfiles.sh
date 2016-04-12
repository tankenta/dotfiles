#!/bin/bash

# 隠しファイルのみ取得してリンクを貼る
for dotfile in .?*; do
    case $dotfile in
	..)
		continue
		;;
	.git)
		continue
		;;
	.gitignore)
		continue
		;;
	.vim)
		continue
		;;
	*.swp)
		continue
		;;
	*.swo)
		continue
		;;
	.config)
		continue
		;;
	# それ以外はシンボリックリンクを張る
	*)
		echo ">> シンボリックリンクを作成:$dotfile"
		ln -s "$PWD/$dotfile" $HOME
		;;
    esac
done

