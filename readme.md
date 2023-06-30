# setup-server

## Instruction

### Create config

```bash
DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl && mkdir --parents "$HOME/tmp" && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jaid/setup-server/main/main/config.bash --output "$HOME/tmp/config.bash"
```

### Edit config (optional)

```bash
nano "$HOME/tmp/config.bash" && cat "$HOME/tmp/config.bash"
```

### Run

```bash
DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install git jq && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jaid/setup-server/main/main/setup.bash --output "$HOME/tmp/setup.bash" && bash -o xtrace "$HOME/tmp/setup.bash" |& tee --append "$HOME/tmp/setup.log"
```