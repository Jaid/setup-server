cloudConfig=$(<cloudconfig.yml)
cloudConfig=$(sed -z 's/\\/\\\\/g' <<<"$cloudConfig")
cloudConfig=$(sed -z 's/\"/\\\"/g' <<<"$cloudConfig")
cloudConfig=$(sed -z 's/\n/\\n/g' <<<"$cloudConfig")
json="{\"automount\":false,\"image\":\"ubuntu-22.04\",\"location\":\"nbg1\",\"name\":\"test\",\"server_type\":\"cx21\",\"ssh_keys\":[\"jaid.jsx+hub@gmail.com\"],\"start_after_create\":true,\"user_data\":\"$cloudConfig\"}"
curl -X POST -H "Authorization: Bearer $hetznerToken" -H "Content-Type: application/json" -d "$json" 'https://api.hetzner.cloud/v1/servers'

# curl -H "Authorization: Bearer $hetznerToken" 'https://api.hetzner.cloud/v1/ssh_keys'
# curl -H "Authorization: Bearer $hetznerToken" 'https://api.hetzner.cloud/v1/floating_ips'
