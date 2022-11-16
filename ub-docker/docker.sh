#!/bin/bash

if [ "$(whoami)" != "root" ]; then
    echo 'You must be root'
    exit
fi

if [ ! -f "/etc/ssh/sshd_config.bak" ]; then
    \cp -f /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

    echo "

PermitRootLogin yes
PasswordAuthentication yes" >> /etc/ssh/sshd_config

    service sshd reload

    # Ref: https://docs.docker.com/engine/install/ubuntu/
    apt update -y
    apt install ca-certificates curl gnupg lsb-release -y

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt update -y
    apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

    docker run hello-world

fi
