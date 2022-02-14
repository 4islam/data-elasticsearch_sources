#!/bin/sh
p=9200;    if [ -n "$1" ]; then p=$1; fi

#echo "/var/lib/docker/volumes/docker_data01c/_data /var/lib/docker/volumes/docker_data02c/_data /var/lib/docker/volumes/docker_data03c/_data" | sudo xargs -n 1 cp -v esConfig/*.solr
#echo "/var/lib/docker/volumes/docker_data01c/_data /var/lib/docker/volumes/docker_data02c/_data /var/lib/docker/volumes/docker_data03c/_data" | sudo xargs -n 1 cp -v esConfig/*.txt

sudo cp -v esConfig/*.solr /etc/elasticsearch
sudo cp -v esConfig/*.txt /etc/elasticsearch

echo "\n\nSetting cluster.routing.allocation.disk.threshold_enabled: false"
curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'

#echo "logger.org.elasticsearch.discovery: DEBUG"
#curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_cluster/settings -d '{ "transient": { "logger.org.elasticsearch.discovery": "DEBUG" } }'

echo "\n\nSetting index.blocks.read_only_allow_delete: null"
curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'

echo "\n\nDeleting existing index"
curl -s -XDELETE "http://localhost:$p/hq" -H 'Content-Type: application/json'

echo "\n\nCreating new index (mapping.json)"
curl -s -XPUT "http://localhost:$p/hq" -d @mapping.json -H 'Content-Type: application/json'
echo "\n\nSetting index.requests.cache.enable"

curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.requests.cache.enable": true }'

echo "\n\nSetting index.mapping.total_fields.limit: 1000"
curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.mapping.total_fields.limit": 1000 }'

echo "\n\nSetting index.number_of_replicas: 5 "
curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.number_of_replicas": 5 }'

rm x*
split hQ.json
  echo "\n\n  - Loading data (hQ.json)"
  for f in xaa xab xac xad xae xaf xag xah xai xaj xak xal xam; do
    echo "\n\nLoading part $f"
    curl -s -XPOST "localhost:$p/hq/_bulk?timeout=5m" --data-binary @$f -H 'Content-Type: application/json' | head -c250
  done; clear;
rm x*

echo "\n"
#curl -XGET localhost:9200/hq/_stats

sleep 10
curl -s -XGET "localhost:$p/hq/_stats/docs" -H 'Content-Type: application/json' #| egrep -o "\"count\":[0-9]+" | head -n1
