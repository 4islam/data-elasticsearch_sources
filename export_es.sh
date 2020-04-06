#!/bin/sh
curl -s -XDELETE "http://localhost:9200/hq"
curl -s -XPUT "http://localhost:9200/hq" -d @~/uploads/mapping.json
curl -s -XPOST localhost:9200/hq/verse/_bulk --data-binary @~/uploads/hQ.json; clear
#curl -XGET localhost:9200/hq/_stats
sleep 7
curl -s -XGET localhost:9200/hq/_stats/docs | egrep -o "\"count\":[0-9]+" | head -n1
