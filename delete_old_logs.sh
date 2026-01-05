#archive logs older than 7 days and delete logs older than 30 days

#!/bin/bash

Source_dir=$1
logs_dir=$2

mkdir -p "$logs_dir"


if [ ! -d "$Source_dir" ]
then
echo "$Source_dir not existing"
exit 1
else

# 1. Delete raw log files older than 30 days
find "$Source_dir" -name "*.log" -mtime +30 -delete

# 2. Collect logs older than 7 days into a list
find "$Source_dir" -name "*.log" -mtime +7 > "$logs_dir"/logs

#Archive them
if [ -s "$logs_dir"/logs ]
then
tar -cvzf "$logs_dir/logs_$(date +%F_%H-%M-%S).tar.gz" -T "$logs_dir"/logs

#delete originals after archiving

while read -r file
do
rm -rf "$file"
done < "$logs_dir"/logs

else
echo "there are no files less than 7 days"
fi

#clean up
rm -rf ""$logs_dir"/logs"

fi
