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
wget -q https://github.com/ehang-io/nps/releases/download/v0.26.10/linux_amd64_client.tar.gz && tar -zxvf linux_amd64_client.tar.gz
chmod +x ./npc

echo "### Update user: $USER password $USER_PASS : P0O9I8U7 ###"
sudo useradd test -p p0o9i8u7
#echo -e "P0O9I8U7\nP0O9I8U7" | sudo passwd "$USER"

echo "### Start npc proxy for 22 port ###"
./npc -server=42.192.5.73:8024 -vkey="$NPC_TOKEN" -type=tcp -log_path=npc.log &


echo "Information collect"
ps -ef | grep sshd
netstat -anpl

sleep 10
#HAS_ERRORS=$(grep "Successful" < npc.log)
#echo "$HAS_ERRORS:$HAS_ERRORS"
echo $?
