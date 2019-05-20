#!/usr/bin/env bash

#yarn global add n
#sudo "$(yarn global bin)/n" stable --quiet # Install latest stable NodeJS via n

executeDownloaded "https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh"
nvm install node
nvm use node
