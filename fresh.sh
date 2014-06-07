#!/bin/sh

echo "Configuring..."

# Change OSX settings
~/.dotfiles/.osx

# Change to zsh
[ "$SHELL" == "/bin/zsh" ] || (echo "Changing shell to zsh..." && chsh -s $(which zsh))

#Install oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || (echo "Installing oh-my-zsh..." && curl -L http://install.ohmyz.sh | sh)

#Add zsh config
[ -f ~/.zshrc ] || cp ~/.dotfiles/.zshrc ~/.zshrc 

#Install Homebrew
which -s brew
[ $? == 0 ] || (echo "Installing Homebrew..." && ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)")

# Functions
function i {
	[[ $(brew ls --versions $1) ]] || (echo "Installing $1" && brew install $1)
}

function t {
	[[ $(brew tap | grep $1) ]] || (echo "Adding tap: $1" && brew tap $1)
}

function c {
	[[ ! $(brew cask info $1 | grep "Not installed") ]] || (echo "Installing $1" && brew cask install $1)
}


# Add Homebrew taps
t caskroom/cask
t caskroom/versions


# Install Homebrew packages
i node
i python3
i todo-txt
i wget
i brew-cask

# Install Apps
c iterm2
c the-unarchiver
c google-chrome
c sublime-text3
c evernote
c skitch
c caffeine
c flux
c calibre
c spotify
c transmission
c vlc
c handbrake
c virtualbox

# Clean up Homebrew cask
brew cask cleanup

#Setup Sublime
stpath="$HOME/Library/Application Support/Sublime Text 3"
stpc="$stpath/Installed Packages/Package Control.sublime-package"
pcsettings="$stpath/Packages/User/Package Control.sublime-settings"
[ -f "$stpc" ] || (echo "Installing Package Control for Sublime..." && curl -o "$stpc" https://sublime.wbond.net/Package%20Control.sublime-package)
[ -f "$pcsettings" ] || cp ~/.dotfiles/sublime-pc-settings.json "$pcsettings"

echo "Done."




