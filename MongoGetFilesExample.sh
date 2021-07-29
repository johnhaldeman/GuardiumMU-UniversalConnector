#!/usr/bin/bash

set -e

HOSTS="auditing-test-shard-00-00.r8qzu.mongodb.net auditing-test-shard-00-01.r8qzu.mongodb.net auditing-test-shard-00-02.r8qzu.mongodb.net"

d=`date +%Y-%m-%d-%H-%M-%S`

cTime=`date +%s`
offset=`expr 60 \* 60`
hourAgo=`expr $cTime - $offset`
lastRun=`cat prevTime`

for host in $HOSTS
do
        filename="mongodb-audit-log-"$host"-"$d;
        url="https://cloud.mongodb.com/api/atlas/v1.0/groups/60f85d2f8b8b1b6d8fb99c93/clusters/"$host"/logs/mongodb-audit-log.gz?startDate="$lastRun"&endDate="$hourAgo
        echo $url;
        curl --user '***************:*************************' --digest \
         --header 'Accept: application/gzip' \
         --request GET $url \
         --output $filename".gz";
    if [ -s $filename".gz" ]
        then
           gunzip -c $filename".gz" > done/$filename".json"
        fi
done

echo $hourAgo > prevTime



