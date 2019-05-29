#!/bin/bash
# get requirements
echo "requirements"
yum install -y \
redhat-lsb-core \
wget \
rpmdevtools \
rpm-build \
createrepo \
yum-utils \
gcc

echo "Get openssl"
# get openssl
wget https://www.openssl.org/source/latest.tar.gz
tar -xvf latest.tar.gz -C /usr/lib
echo "Get nginx sources + requirements"
# get nginx plus dependencies
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm
yum-builddep /root/rpmbuild/SPECS/nginx.spec -y
echo "update SPEC file and rebuild RPM"
# update SPEC file and add openssl
sed -i 's|--with-debug|--with-openssl=/usr/lib/openssl-1.1.1c|' /root/rpmbuild/SPECS/nginx.spec
# rebuild NGINX with openssl support
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
echo "install NGINX locally"
# install and run NGINX from created RPM
yum localinstall -y \
/root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
# Upadte nginx configuration
sed -i '/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf
systemctl enable --now nginx
echo "Create REPO"
# create your own repository
mkdir /usr/share/nginx/html/repo
# copy RPM to repo folder
cp rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
# add another RPM
wget http://www.percona.com/downloads/percona-release/redhat/0.1-6/percona-release-0.1-6.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-0.1-6.noarch.rpm
# initializing repo
createrepo /usr/share/nginx/html/repo/

# add rpm repo to available list
cat >> /etc/yum.repos.d/custom.repo << EOF
[custom]
name=hw08
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
