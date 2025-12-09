#!/bin/sh
p=9200;    if [ -n "$1" ]; then p=$1; fi

# Load .env file from parent directory or current directory
if [ -f "../.env" ]; then
    export $(cat ../.env | xargs)
elif [ -f ".env" ]; then
    export $(cat .env | xargs)
fi

key="$ES_API_KEY"
if [ -z "$key" ]; then
    echo "Error: ES_API_KEY not found in .env file"
    exit 1
fi

container_name="es-local-dev"

verify_es_health() {
    echo "Waiting for Elasticsearch to be healthy..."
    until curl -s "localhost:$p/_cluster/health" >/dev/null; do
        echo "Elasticsearch is not ready yet..."
        sleep 5
    done
    echo "Elasticsearch is ready."
}

check_and_install_plugin() {
    plugin_name="analysis-smartcn"
    if docker exec "$container_name" bin/elasticsearch-plugin list | grep -q "$plugin_name"; then
        echo "Plugin $plugin_name is already installed."
    else
        echo "Plugin $plugin_name not found. Installing..."
        docker exec "$container_name" bin/elasticsearch-plugin install -b "$plugin_name"
        echo "Restarting container $container_name to apply changes..."
        docker restart "$container_name"
        verify_es_health
    fi
}

copy_config_files() {
    echo "Copying config files to container..."
    docker cp esConfig/. "$container_name":/usr/share/elasticsearch/config/
}

# Run setup steps
check_and_install_plugin
copy_config_files

# Wait for ES to be up if we didn't restart (or just to be safe)
verify_es_health


echo "\n\nSetting cluster.routing.allocation.disk.threshold_enabled: false"
curl -XPUT -H "Content-Type: application/json" -H "Authorization: ApiKey $key" http://localhost:$p/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'

#echo "logger.org.elasticsearch.discovery: DEBUG"
#curl -XPUT -H "Content-Type: application/json" http://localhost:$p/_cluster/settings -d '{ "transient": { "logger.org.elasticsearch.discovery": "DEBUG" } }'

echo "\n\nSetting index.blocks.read_only_allow_delete: null"
curl -XPUT -H "Content-Type: application/json" -H "Authorization: ApiKey $key" http://localhost:$p/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'

echo "\n\nDeleting existing index"
curl -s -XDELETE "http://localhost:$p/hq" -H 'Content-Type: application/json' -H "Authorization: ApiKey $key"

echo "\n\nCreating new index (mapping.json)"
curl -s -XPUT "http://localhost:$p/hq" -d @mapping.json -H 'Content-Type: application/json' -H "Authorization: ApiKey $key"
echo "\n\nSetting index.requests.cache.enable"

curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.requests.cache.enable": true }' -H "Authorization: ApiKey $key"

echo "\n\nSetting index.mapping.total_fields.limit: 1000"
curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.mapping.total_fields.limit": 1000 }' -H "Authorization: ApiKey $key"

echo "\n\nSetting index.number_of_replicas: 5 "
curl -XPUT "localhost:$p/hq/_settings" -H 'Content-Type: application/json' -d'{ "index.number_of_replicas": 5 }' -H "Authorization: ApiKey $key"

rm x*
split hQ.json
  echo "\n\n  - Loading data (hQ.json)"
  for f in xaa xab xac xad xae xaf xag xah xai xaj xak xal xam; do
    echo "\n\nLoading part $f"
    curl -s -XPOST "localhost:$p/hq/_bulk?timeout=5m" --data-binary @$f -H 'Content-Type: application/json' -H "Authorization: ApiKey $key" | head -c1500
    rm $f
  done; clear;

echo "\n"
#curl -XGET localhost:9200/hq/_stats

sleep 10
curl -s -XGET "localhost:$p/hq/_stats/docs" -H 'Content-Type: application/json' -H "Authorization: ApiKey $key" #| egrep -o "\"count\":[0-9]+" | head -n1
