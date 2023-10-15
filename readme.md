# setup-server

## Instruction

### Create config

```bash
DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl && mkdir --parents "$HOME/temp" && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jaid/setup-server/main/main/config.bash --output "$HOME/temp/config.bash"
```

### Edit config (optional)

```bash
nano "$HOME/temp/config.bash" && cat "$HOME/temp/config.bash"
```

### Run

```bash
DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install git jq && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jaid/setup-server/main/main/setup.bash --output "$HOME/temp/setup.bash" && bash -o xtrace "$HOME/temp/setup.bash" |& tee --append "$HOME/temp/setup.log"
```