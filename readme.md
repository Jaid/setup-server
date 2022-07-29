# setup-server

### Pull all scripts

```bash
[ ! -d ~/src/scripts ] || rm -rf ~/src/scripts && [ ! -d ~/src/setup-server ] || rm -rf ~/src/setup-server && curl --silent --location --retry 3 --fail 'https://raw.githubusercontent.com/Jaid/setup-server/dist/bin/downloadJaidScripts' | GITHUB_TOKEN=ghp_000000000000000000000000000000000000 bash
```