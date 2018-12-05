#!/bin/sh
s=1;    if [ -n "$1" ]; then s=$1; fi
l=100;  if [ -n "$2" ]; then l=$2; fi
b=1;    if [ -n "$3" ]; then b=$3; fi

curl --output /dev/null -XDELETE http://localhost:9200/hq; sleep 3;
curl -XPUT localhost:9200/hq/ --data-binary @../mapping.json;
for i in `seq 1 $b`; do
  #echo Tail of ... $((2*$l)), starting from $((2*$i*$l))
  cat ../hQ.json | head -n$((2*($i*$l+$s-1))) | tail -n$((2*$l)) | \
    curl -s -XPOST localhost:9200/hq/verse/_bulk --data-binary @- --output /dev/null; sleep 4;
  curl -s -XGET localhost:9200/hq/_stats/docs;
  node ./persian/quran_ar_persian.js $((($i-1)*$l+$s)) $l > ./persian/outputs/verses_$(($i*$l+$s-1)).txt;

  cat ./persian/original/tokenized.txt | head -n$(($i*$l+$s-1)) | tail -n$(($l)) \
        > ./persian/original/tokenized_$(($i*$l+$s-1)).txt

  ./persian/outputs/compare.sh $(($i*$l+$s-1))
done
