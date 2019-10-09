#!/bin/bash

# author: Xiping Hu
# email: XipingHu@hust.edu.cn

# Usage:
# chwod +x backup.sh
# sudo ./backup.sh
# Restore: 
# Restore Partitiontable: sfdisk /dev/sda < sda.dump
# Restore all disk: pigz -dc /path/to/backup.img.gz | dd of=/dev/sda status=progress

# Create archive filename.
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

day=$(date +"%Y-%m-%d_%H-%M-%S")
hostname="hxp-arch"
archive_filename="$hostname-$day.img.gz"
dest="./backup/$(date +"%Y-%m-%d")"

# Print start status message.
echo "Backing up /dev/sda to $dest/$archive_filename"
echo

# Backup the files using dd.
mkdir backup
mkdir $dest
touch "$dest/comments-$day.txt"
nano "$dest/comments-$day.txt"
time dd if=/dev/sda conv=sync,noerror bs=64K status=progress | pigz -c > $dest/$archive_filename
sfdisk -d /dev/sda > $dest/sda-$day.dump
fdisk -l /dev/sda > $dest/fdisk-$day.info
# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
echo "Shutting Down..."
shutdown
