#!/bin/sh
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'
echo "\n"
curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
echo "\n"
curl -s -XDELETE http://localhost:9200/hq -H 'Content-Type: application/json'
echo "\n"
curl -s -XPUT http://localhost:9200/hq -d @mapping.json -H 'Content-Type: application/json'
echo "\n"
curl -XPUT "localhost:9200/hq/_settings?pretty" -H 'Content-Type: application/json' -d'{ "index.requests.cache.enable": true }'
echo "\n"
curl -s -XPOST localhost:9200/hq/_bulk --data-binary @hQ.json -H 'Content-Type: application/json'; clear
echo "\n"
#curl -XGET localhost:9200/hq/_stats
sleep 10
curl -s -XGET localhost:9200/hq/_stats/docs -H 'Content-Type: application/json' | egrep -o "\"count\":[0-9]+" | head -n1
