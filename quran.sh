#!/bin/sh
ARG1=${1:-ar_original_noor}
ARG2=${2:-output.txt}
while read line; do
  out=`curl -s -XGET "localhost:9200/hq/_analyze" -H 'Content-Type: application/json' -d'{"analyzer" : "'$ARG1'","text" : "'"$line"'"}' | jq '.[][].token'|tr -d '"'| awk '{print}' ORS=' ';echo ""`
  echo $out | tee -a $ARG2
  if [ -z "$out" ];then #if empty
        echo $line >> $ARG2.error
  fi
done
