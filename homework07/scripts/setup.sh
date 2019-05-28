#!/bin/bash

# Task 01. Restrict login access on weekends to all users except users in "admin" group.

groupadd admin

useradd day --groups admin && \
useradd night --groups admin && \
useradd friday --groups admin

echo "Otus2019" | passwd --stdin day && \
echo "Otus2019" | passwd --stdin night && \
echo "Otus2019" | passwd --stdin friday

sudo bash -c "sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config && systemctl restart sshd.service"

cp /vagrant/scripts/sshd        /etc/pam.d/sshd
cp /vagrant/scripts/time.conf   /etc/security/time.conf

# Task 02. Grant current user root rights.

cp /vagrant/scripts/capability.conf /etc/security/capability.conf
cp /vagrant/scripts/su /etc/pam.d/su
