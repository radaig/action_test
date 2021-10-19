#!/bin/bash

if [[ -z "$NPC_TOKEN" ]]; then
  echo "Please set 'NPC_TOKEN'"
  exit 2
fi

if [[ -z "$USER_PASS" ]]; then
  echo "Please set 'USER_PASS' for user: $USER"
  exit 3
fi

echo "### Install NPC ###"
wget -q https://github.com/ehang-io/nps/releases/download/v0.26.10/freebsd_amd64_client.tar.gz && tar -zxvf freebsd_amd64_client.tar.gz
cd npc && chmod +x ./npc

echo "### Update user: $USER password ###"
echo -e "$USER_PASS\n$USER_PASS" | sudo passwd "$USER"

echo "### Start npc proxy for 22 port ###"
./npc -server=radaig.cn:8024 -vkey="$NGROK_TOKEN" -type=tcp -log_path=npc.log

sleep 10
HAS_ERRORS=$(grep "command failed" < .npc.log)

if [[ -z "$HAS_ERRORS" ]]; then
  echo ""
  echo "=========================================="
  echo "To connect: $(grep -o -E "tcp://(.+)" < .ngrok.log | sed "s/tcp:\/\//ssh $USER@/" | sed "s/:/ -p /")"
  echo "=========================================="
else
  echo "$HAS_ERRORS"
  exit 4
fi
