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

find "$Source_dir" -name "*.log" -mtime +30 -delete

find "$Source_dir" -name "*.log" -mtime +7 > "$logs_dir"/logs

if [ -s "$logs_dir"/logs ]
then
tar -cvzf "$logs_dir/logs_$(date +%F).tar.gz" -T "$logs_dir"/logs

while read -r file
do

rm -rf "$file"

done < "$logs_dir"/logs

else
echo "there are no files less than 7 days"
fi


rm -rf ""$logs_dir"/logs"

fi
