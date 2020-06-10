#!/usr/bin/env bash

currentDirectory=$PWD
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# Get Ansible public cloud roles (Jenkins)
ansible-galaxy install -r ../ansible/playbooks/requirements.yml

cd ./templates
packer build ubuntu-php-aws.json

cd $currentDirectory