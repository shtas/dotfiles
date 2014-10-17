#!/bin/sh


# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring..."

# Change OSX settings
~/.dotfiles/.osx

#Install Homebrew
which -s brew
[ $? == 0 ] || (echo "Installing Homebrew..." && ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add taps if they not already added
function t {
	[[ $(brew tap | grep $1) ]] || (echo "Adding tap: $1" && brew tap $1)
}

# Add Homebrew taps
t caskroom/cask
t caskroom/versions


# Install packages
~/.dotfiles/packages.sh


# Change to zsh
[ "$SHELL" == "/bin/zsh" ] || (echo "Changing shell to zsh..." && chsh -s $(which zsh))

#Install oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || (echo "Installing oh-my-zsh..." && curl -L http://install.ohmyz.sh | sh)

#Add zsh config
cp ~/.dotfiles/.zshrc ~/.zshrc
source ~/.zshrc


# Install apps
~/.dotfiles/apps.sh


#Setup Sublime
stpath="$HOME/Library/Application Support/Sublime Text 3"
stpc="$stpath/Installed Packages/Package Control.sublime-package"
pcsettings="$stpath/Packages/User/Package Control.sublime-settings"
[ -f "$stpc" ] || (echo "Installing Package Control for Sublime..." && curl -o "$stpc" https://sublime.wbond.net/Package%20Control.sublime-package)
[ -f "$pcsettings" ] || cp ~/.dotfiles/sublime-pc-settings.json "$pcsettings"

echo "Done."




