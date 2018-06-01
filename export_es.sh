#!/bin/sh
curl -XDELETE "http://localhost:9200/hq"
curl -XPUT "http://localhost:9200/hq" -d @HQ_Artifacts_Prod/mapping.json
curl -s -XPOST localhost:9200/hq/verse/_bulk --data-binary @hQv7.5.txt; clear
curl -XGET localhost:9200/hq/_stats
