#!/usr/bin/env bash
set -o errexit

curl -X POST "https://discord.com/api/webhooks/579929585060413440/VfD8FlZs3VOtxFeOdLHJkjf7nzXMNnyqrFV5GXEeuYzkj2YWHiKGArjc3yUhvkdYraB3" -d '{"content":"Server created!"}' -H "Content-Type: application/json"

# ufw allow ssh
# ufw --force enable
# service NetworkManager restart

setupUser

curl -X POST "https://discord.com/api/webhooks/579929585060413440/VfD8FlZs3VOtxFeOdLHJkjf7nzXMNnyqrFV5GXEeuYzkj2YWHiKGArjc3yUhvkdYraB3" -d '{"content":"Server done!"}' -H "Content-Type: application/json"
