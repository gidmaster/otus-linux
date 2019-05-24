#!/bin/bash

yum update -y
yum install -y vim

# we could not listen to some ports when enforcing mode is enabled
# set permissive mode
setenforce 0

/vagrant/scripts/monitor/setup.sh
/vagrant/scripts/fastcgi/setup.sh
/vagrant/scripts/apache/setup.sh