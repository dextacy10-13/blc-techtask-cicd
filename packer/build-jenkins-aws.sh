#!/usr/bin/env bash

currentDirectory=$PWD
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# Get Ansible public cloud roles (Jenkins)
ansible-galaxy install -r ../ansible/playbooks/requirements.yml

cd ./templates
packer build -var-file=../ubuntu-aws.env ubuntu-aws.json

cd $currentDirectory