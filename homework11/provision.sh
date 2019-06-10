#!/bin/bash
yum install ansible -y
cd /vagrant/playbooks
ansible-playbook provision.yml