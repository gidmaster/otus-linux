#!/bin/bash

yum install -y httpd

# remove default port. We will provide port in config file
sed -i '/Listen 80/d' /etc/httpd/conf/httpd.conf

cp /vagrant/apache/httpd@.service /etc/systemd/system
cp /vagrant/apache/template.conf /etc/httpd/conf.d/template.conf
cp /vagrant/apache/test-configs/httpd{1,2} /etc/sysconfig

systemctl enable --now httpd@httpd1.service
systemctl enable --now httpd@httpd2.service
