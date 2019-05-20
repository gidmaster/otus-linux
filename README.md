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
