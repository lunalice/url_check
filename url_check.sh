#!/bin/bash
# args=file_path.csv
# id,url
file_path=$1
if [ -f "output.csv" ]; then
	rm output.csv
fi

OLDIFS=$IFS;
IFS=$'\n';
echo "id,url,code" >> output.csv
for url in $(cat "$file_path"); do
	id=$(echo "$url" | sed -e "s/\,.*//g")
	url=$(echo "$url" | sed -e "s/.*\,//g")
	code=$(curl -LI "$url" -o /dev/null -w '%{http_code}\n' -s)
	echo "id:${id} url:${url} code:${code}"
	echo "${id},${url},${code}" >> output.csv
	sleep 1
done
IFS=$OLDIFS
