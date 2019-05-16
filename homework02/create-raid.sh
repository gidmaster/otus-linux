#!/bin/bash
# Forced create superblock
mdadm --zero-superblock --force /dev/sd{b,c,d,e,f}
# Create new raid-array
mdadm --create --verbose /dev/md0 -l 6 -n 5 /dev/sd{b,c,d,e,f}
# make mdadm.conf file
mkdir /etc/mdadm
echo "DEVICE partitions" > /etc/mdadm/mdadm.conf
mdadm --detail --scan --verbose | awk '/ARRAY/ {print}' >> /etc/mdadm/mdadm.conf

# Create GPT Table on RAID ARRAY
parted -s /dev/md0 mklabel gpt
# Create partitions
parted /dev/md0 mkpart primary ext4 0% 20%
parted /dev/md0 mkpart primary ext4 20% 40%
parted /dev/md0 mkpart primary ext4 40% 60%
parted /dev/md0 mkpart primary ext4 60% 80%
parted /dev/md0 mkpart primary ext4 80% 100%
# Creafe File Systems on partitions
for i in $(seq 1 5)
do 
    mkfs.ext4 /dev/md0p$i
done
# Make filders for them
mkdir -p /raid/part{1,2,3,4,5}
# mount them
for i in $(seq 1 5)
do 
    mount /dev/md0p$i /raid/part$i
done