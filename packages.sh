#!/bin/sh

# Install package if not already installed
function i {
	[[ $(brew ls --versions $1) ]] || (echo "Installing $1" && brew install $1)
}


# Install Homebrew packages
i git
i node
i python3
i todo-txt
i wget
i mongodb
i brew-cask