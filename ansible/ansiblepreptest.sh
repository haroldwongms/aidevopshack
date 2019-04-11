#!/bin/bash

export WORKING_DIR=$WORKING_DIR

## Install pre-requisite packages
sudo apt-get remove --purge ansible
sudo apt-get install -y python-setuptools
sudo apt-get update && sudo apt-get install -y libssl-dev libffi-dev python-dev python-pip 
sudo pip install ansible

# sudo mkdir /etc/ansible
sudo cat > ~/.ansible.cfg << EOF
host_key_checking = False
EOF

#sudo sed -i -e "s/^#host_key_checking = False/host_key_checking = False/" /etc/ansible/ansible.cfg

cat /etc/ansible/ansible.cfg

## Install Ansible and Azure SDKs via pip
sudo pip install ansible[azure]

sudo apt-get update
sudo apt-get install curl apt-transport-https lsb-release gpg

## Install Azure CLI
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-get update
sudo apt-get install azure-cli

# Execute az login with service principal for ansible playbook execution

az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

az account set -s $ARM_SUBSCRIPTION_ID

az account show

# Generate ssh key for VM creation
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''



