#!/bin/sh

# Install app if not already installed
function c {
	[[ ! $(brew cask info $1 | grep "Not installed") ]] || (echo "Installing $1" && brew cask install $1)
}

# Install Apps
c iterm2
c the-unarchiver
c google-chrome
c firefox
c lastpass-universal
c sublime-text3
c evernote
c dropbox
c skitch
c caffeine
c flux
c calibre
c spotify
c transmission
c vlc
c handbrake
c virtualbox
c daisydisk
c basecamp
c appcleaner
c heroku-toolbelt
c mou
c aquamacs

# Clean up Homebrew cask
brew cask cleanup
