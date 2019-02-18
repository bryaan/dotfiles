#!/bin/bash
brew update
brew upgrade
# Keep only programs with links, and only the last linked version.
brew cleanup -s
brew cask upgrade
# diagnotics
brew doctor
brew missing
brew cask doctor

