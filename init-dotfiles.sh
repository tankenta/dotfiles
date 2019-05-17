#!/bin/bash

# Create symbolic links only for hidden files
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
	# vim config files are set by another script
	.vim)
		continue
		;;
	.vimrc)
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
	# Others: Create symbolic links
	*)
		if [ -e "$HOME/$dotfile" ]; then
			newpath="${HOME}/${dotfile}.bak"
			echo ">> Backup old file: $HOME/$dotfile to $newpath"
			mv "$HOME/$dotfile" $newpath
		fi
		echo ">> Create symbolic link: $dotfile"
		ln -s "$PWD/$dotfile" $HOME
		;;
    esac
done

