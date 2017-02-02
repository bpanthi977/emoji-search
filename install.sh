#!/bin/bash

_INSTALL_PREFIX=/usr/local/
_APP_DIR=/usr/local/share/applications

uninstall_emojisearch(){
	# Remove files
	rm -f $_INSTALL_PREFIX/bin/emoji-search
	rm -rf $_INSTALL_PREFIX/share/emoji-search
    # Remove desktop entry
    rm -f $_APP_DIR/emoji-search.desktop 
	# Uninstall iconsa
	for SIZE in 16 22 24 32 48 64 ; do
		xdg-icon-resource uninstall --theme ubuntu-mono-dark --size ${SIZE} emoji-search
		xdg-icon-resource uninstall --theme ubuntu-mono-light --size ${SIZE} emoji-search
		xdg-icon-resource uninstall --theme hicolor --size ${SIZE} emoji-search
	done
}

install_emojisearch(){
	# Make directories
	mkdir -p $_INSTALL_PREFIX/bin
	mkdir -p $_INSTALL_PREFIX/share/emoji-search
	# Copy files
	cp emoji-search $_INSTALL_PREFIX/bin
	cp -rf assets $_INSTALL_PREFIX/share/emoji-search/
	# Install icons
	for SIZE in 16 22 24 32 48 64 ; do
		xdg-icon-resource install --theme ubuntu-mono-dark --size ${SIZE} assets/icon-mono-dark-${SIZE}.png emoji-search
		xdg-icon-resource install --theme ubuntu-mono-light --size ${SIZE} assets/icon-mono-light-${SIZE}.png emoji-search
		xdg-icon-resource install --theme hicolor --size ${SIZE} assets/icon-default-${SIZE}.png emoji-search
	done
    # Install desktop entry
    mkdir -p $_APP_DIR
    cp -f emoji-search.desktop $_APP_DIR
}

cd "${0%/*}"

if [ "$(id -u)" != "0" ]; then
	echo "Since you are running this as plain user, the program will be installed just for the current user."
	_INSTALL_PREFIX=~/.local
        _APP_DIR=~/.local/share/applications
else
	_INSTALL_PREFIX=/usr/local
        _APP_DIR=/usr/local/share/applications
fi

if [ -f "$_INSTALL_PREFIX/bin/emoji-search" ] ; then
	read -p "Installation detected. Press enter to uninstall or Ctrl-C to abort"
	uninstall_emojisearch
	echo "Uninstall completed."
else
	read -p "Press enter to install emoji-search or Ctrl-C to abort"
	install_emojisearch
	echo "Installation completed."
fi

