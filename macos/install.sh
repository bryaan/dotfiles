# Mac app store update
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -i -a

# Install Command Line Tools if you haven't already.
xcode-select --install

# Enable command line tools
sudo xcode-select --switch /Library/Developer/CommandLineTools
