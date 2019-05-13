#!/bin/sh

export PYTHONWARNINGS=ignore::UserWarning
ansible-playbook -vvvv --vault-password-file=~/vault_password.txt  $1.yml