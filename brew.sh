#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
#brew install coreutils
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
#brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
#brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
#brew install gnu-sed --with-default-names
# Install Bash 4.
brew install bash
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Install `wget` with IRI support.
brew install wget --with-iri

# Install other useful binaries.

brew install git
# brew install git-lfs
brew install git-flow
brew install git-extras
brew install httpie
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Install Heroku
# brew install heroku-toolbelt
# heroku update

# Install Cask
brew install caskroom/cask/brew-cask
brew tap caskroom/versions
# Install Python
brew install python
brew install python3

# Instal rbenv and Ruby
brew install rbenv ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile  
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile 
rbenv install 2.2.4

# install java
brew cask install java
# Install GO
brew cask install go

# Core casks
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" xquartz

# Development tool casks
brew cask install --appdir="/Applications" sublime-text3
# brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" virtualbox
brew cask install --a/Users/jwise/macosx-setup/dev-setup.shppdir="/Applications" vagrant
# brew cask install --appdir="/Applications" heroku-toolbelt
brew cask install --appdir="/Applications" macdown
brew cask install --appdir="/Applications" visual-studio-code
brew cask install --appdir="/Applications" sourcetree
brew cask install --appdir="/Applications" appcode
brew cask install --appdir="/Applications" charles
brew cask install --appdir="/Applications" filezilla
brew cask install --appdir="/Applications" intellij-idea
brew cask install --appdir="/Applications" rubymine
brew cask install --appdir="/Applications" phpstorm
brew cask install --appdir="/Applications" pycharm
brew cask install --appdir="/Applications" webstorm
brew cask install --appdir="/Applications" clion
brew cask install --appdir="/Applications" datagrip
brew cask install --appdir="/Applications" netbeans
brew cask install --appdir="/Applications" node
brew cask install --appdir="/Applications" arduino
brew cask install --appdir="/Applications" fritzing

# Misc casks
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" thunderbird
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" gimp
brew cask install --appdir="/Applications" parallels-desktop
brew cask install --appdir="/Applications" whatsize
brew cask install --appdir="/Applications" wireshark
brew cask install --appdir="/Applications" 1password
brew cask install --appdir="/Applications" airserver
brew cask install --appdir="/Applications" microsoft-office
brew cask install --appdir="/Applications" amazon-music
brew cask install --appdir="/Applications" jump-desktop
brew cask install --appdir="/Applications" snagit
brew cask install --appdir="/Applications" xtrafinder
# Install Docker, which requires virtualbox
brew install docker
brew install boot2docker

# Remove outdated versions from the cellar.
brew cleanup

#TODO:locklizard