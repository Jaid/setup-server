name=${name:-test}
location=${location:-nbg1}
type=${type:-cax11}
sshKey=${sshKey:-vps}
ubuntuVersion=${ubuntuVersion:-22.04}

if [[ -z "$hetznerToken" ]]; then
  echo "Please set hetznerToken"
  exit 1
fi

cloudConfig=$(<cloudconfig.yml)
cloudConfig=$(sed -z 's/\\/\\\\/g' <<<"$cloudConfig")
cloudConfig=$(sed -z 's/\"/\\\"/g' <<<"$cloudConfig")
cloudConfig=$(sed -z 's/\n/\\n/g' <<<"$cloudConfig")
json="{\"automount\":false,\"image\":\"ubuntu-$ubuntuVersion\",\"location\":\"$location\",\"name\":\"$name\",\"server_type\":\"$type\",\"ssh_keys\":[\"$sshKey\"],\"start_after_create\":true,\"user_data\":\"$cloudConfig\"}"
curl -X POST -H "Authorization: Bearer $hetznerToken" -H "Content-Type: application/json" -d "$json" 'https://api.hetzner.cloud/v1/servers'

# curl -H "Authorization: Bearer $hetznerToken" 'https://api.hetzner.cloud/v1/ssh_keys'
# curl -H "Authorization: Bearer $hetznerToken" 'https://api.hetzner.cloud/v1/floating_ips'
