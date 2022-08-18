# setup-server

### Pull all scripts

```bash
export GITHUB_TOKEN=ghp_000000000000000000000000000000000000 && mkdir --parents ~/src && [ ! -d ~/src/scripts ] || rm -rf ~/src/scripts && [ ! -d ~/src/setup-server ] || rm -rf ~/src/setup-server && curl --silent --location --retry 3 --fail --show-error 'https://raw.githubusercontent.com/Jaid/setup-server/dist/bin/downloadJaidScripts' | bash
```

### Setup

```bash
#!/usr/bin/env bash
set -o errexit
set -o xtrace

echo '
export PATH="$PATH:$HOME/src/scripts/bin"
disableSudoPassword
aptUpgrade
installGist 8e6f2105498f7f2bcff9822f38832c67 # .bashrc
installGist e68ff74b342ffbf708620b37a617eb1d # .env
installGist 51021323256c14442c03eacdd3c56c3c # .secrets
sed --in-place "s|ghp_000000000000000000000000000000000000|$GITHUB_TOKEN|g" ~/.secrets
source ~/.bashrc
installGist d519aff77c198b0c452ba792358b6545 # htoprc
installGist b81a839a438693a86718d3bb6347a9e4 # .gitconfig
installGist eac9757fdb899067a64f5880524823d9 # locale.gen
setupLanguage
installNano
installGrc
installGh
installNode
#installCoolTools
installZsh
' > ~/setup.bash

bash setup.bash > setup.log
```
