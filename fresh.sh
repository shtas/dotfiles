#!/bin/sh


# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Configuring..."

# Change OSX settings
~/.dotfiles/.osx

#Install Homebrew
which -s brew
[ $? == 0 ] || (echo "Installing Homebrew..." && ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)")

# Add Homebrew taps
t caskroom/cask
t caskroom/versions

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



# Install Homebrew packages
i git
i node
i python3
i todo-txt
i wget
i brew-cask

# Change to zsh
[ "$SHELL" == "/bin/zsh" ] || (echo "Changing shell to zsh..." && chsh -s $(which zsh))

#Install oh-my-zsh
[ -d "$HOME/.oh-my-zsh" ] || (echo "Installing oh-my-zsh..." && curl -L http://install.ohmyz.sh | sh)

#Add zsh config
[ -f ~/.zshrc ] || cp ~/.dotfiles/.zshrc ~/.zshrc 


# Install Apps
c iterm2
c the-unarchiver
c google-chrome
c firefox
c lastpass-universal
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




