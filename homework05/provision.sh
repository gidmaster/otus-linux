#!/bin/bash

yum install -y mailx

cp /vagrant/scripts/notification.sh /etc/cron.hourly/