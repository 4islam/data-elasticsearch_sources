#!/bin/sh
p=9200;    if [ -n "$1" ]; then p=$1; fi

curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'
echo ""
curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'
echo ""
curl -s -XDELETE "http://localhost:$p/hq" -H 'Content-Type: application/json'
echo ""
curl -s -XPUT "http://localhost:$p/hq" -d @mapping.json -H 'Content-Type: application/json'
echo ""
curl -XPUT "localhost:$p/hq/_settings?pretty" -H 'Content-Type: application/json' -d'{ "index.requests.cache.enable": true }'
echo ""
curl -s -XPOST "localhost:$p/hq/_bulk" --data-binary @hQ.json -H 'Content-Type: application/json'; clear
echo ""
#curl -XGET localhost:9200/hq/_stats
sleep 10
curl -s -XGET "localhost:$p/hq/_stats/docs" -H 'Content-Type: application/json' | egrep -o "\"count\":[0-9]+" | head -n1
