# setup-server

## Instruction

### Create config

```bash
set -o errexit -o pipefail -o xtrace && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes update && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes upgrade && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install curl && mkdir --parents "$HOME/tmp" && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://raw.githubusercontent.com/Jaid/setup-server/main/main/config.bash --output "$HOME/tmp/config.bash"
```

### Edit config (optional)

```bash
nano "$HOME/tmp/config.bash"
```

### Run

```bash
set -o errexit -o pipefail -o xtrace && DEBIAN_FRONTEND=noninteractive sudo apt-get --option Acquire::Retries=60 --option Acquire::http::Timeout=180 --yes install git jq && curl --location --retry 3 --fail --silent --show-error --header 'Cache-Control: no-cache' https://gist.githubusercontent.com/Jaid/6e6bd1d02d3d74513d662634c3dc26a9/raw/setup.bash --output "$HOME/.tmp/setup.bash" && bash -o errexit -o pipefail -o xtrace "$HOME/.tmp/setup.bash" |& tee --append "$HOME/.tmp/setup.log"
```