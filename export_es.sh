#!/bin/sh
curl -s -XDELETE "http://localhost:9200/hq" -H 'Content-Type: application/json'
curl -s -XPUT "http://localhost:9200/hq" -H 'Content-Type: application/json' -d @mapping.json
curl -s -XPOST localhost:9200/hq/verse/_bulk curl -s -XPUT "http://localhost:9200/hq" -H 'Content-Type: application/json' -d @mapping.json --data-binary @hQ.json; clear
#curl -XGET localhost:9200/hq/_stats
sleep 7
curl -s -XGET localhost:9200/hq/_stats/docs curl -s -XPUT "http://localhost:9200/hq" -H 'Content-Type: application/json' -d @mapping.json | egrep -o "\"count\":[0-9]+" | head -n1
