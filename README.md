# Repo with homeworks from Linux Administrator Course.

## Homework 01
**Make custom kernel.**
1. Get any kernel version from kernel.org
2. Put `.config` file into derectory with new kernel.
3. Make kernel with new packages.
4. Publish `.config` file
5. Publish list of installed pakages. you can get it from `/var/log/yum.log`
6. Publish `Vagrantfile`
## Homework 02
**Create RAID array**
1. Add new disk into `Vagrantfile`.
2. Create RAID0/5/10 array on your choice.
3. Make `mdadm.conf` file with current configuration. To assamble RAID array during the boot procedure.
4. Broke/restore RAID array.
5. Create GTP Table on RAID array and 5 partitions.
6. Make `build script` and add it into `Vagrantfile`.
## Homework 03
**Work with LVM**
1. Reduce volume `/`to 8GB.
2. Create volume for `/home`
3. Create volume for `/var`
4. Make mirror for `/var`
5. Create volume for `/home` and make snapshot and restor from it.
## Homework 04
1. Reset `root` password deffirent options.
2. Rename volume group.
3. Add module to boot.
## Homework 05
1. Make script for `cron` which sends to e-mail `k.****@gmail.com` every hour:
    * X IP adresses (with most number of requests) with number of requests since the last script's run.
    * Y requested IP addresses (with most number of requests) with number of requests since the last script's run.
    * All errors since the last script's run.
    * List of return codes with number of requests since the last script's run.
E-mail should include time range. Also script should include multirun protection.
## Homework 06
1. Write service. Service should monitor into log file and look for `<key word>` every 30 seconds. Log file and word should be in `/etc/sysconfig`.
2. Install `spawn-fgci` from `epel` and re-write init-file to unit-file. The service name should be the same.
3. Update apache(httpd) unit-file to run multi-instances with diffirent configurations.
4. Download demo-version AtlasianJira and re-write main script to unit-file.
## Homework 07
1. Restrict login access on weekends to all users except users in `admin` group.
2. Grant current user root rights.
