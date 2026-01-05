#archive logs older than 7 days and delete logs older than 30 days

#!/bin/bash

Source_dir=$1
logs_dir=$2
mkdir -p $logs_dir

touch $logs_dir/logs

if [! -d $Source_dir]
then
echo "$Source_dir not existing"
exit 1
else

find $Source_dir -name *.log -mtime +30 -delete

find $Source_dir -name *.log -mtime +7 > $logs_dir/logs


tar -cvzf $logs_dir/logs_$(date).gz $logs_dir/logs

fi
