#!/bin/bash

cp /vagrant/scripts/monitor/monitor.sh /usr/bin/monitor.sh
cp /vagrant/scripts/monitor/monitor.service /etc/systemd/system/monitor.service
cp /vagrant/scripts/monitor/monitor.timer /etc/systemd/system/monitor.timer
cp /vagrant/scripts/monitor/monitor.conf /etc/sysconfig/monitor

systemctl enable --now monitor.timer