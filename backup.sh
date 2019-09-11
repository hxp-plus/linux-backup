#!/bin/bash

# author: Xiping Hu
# email: hxp@hust.edu.cn

# Usage:
# chwod +x backup.sh
# sudo ./backup.sh


# What to backup.
echo "What to backup?(default:/home /var /lib /bin /usr /etc /root /boot /opt)"
read backup_files
if ["$backup_files" == ""]
   then
       backup_files="/home /var /lib /bin /usr /etc /root /boot /opt"
fi


# Where to backup to.
echo "Where to Backup?(default:/mnt/backup)"
read dest
if ["$dest" == ""]
then
   dest="/mnt/backup"
fi
if [ ! -d "$dest" ]
then
    mkdir "$dest"
fi
    

# Create archive filename.
day=$(date +"%m-%d-%Y-%H:%M:%S")
hostname=$(hostname -s)
archive_filename="$hostname-$day.tgz"


# Print start status message.
echo "Backing up $backup_files to $dest/$archive_filename"
date
echo


# Backup the files using tar.
tar czf $dest/$archive_filename $backup_files


# Print end status message.
echo
echo "Backup finished"
date


# Long listing of files in $dest to check file sizes.
ls -lh $dest
echo
echo
echo "To restore, run: 
cd /
sudo tar -xzvf $dest/$archive_filename"
