#!/bin/sh
# Authors: Naveed ul Islam
# Date: 2021-04-04

column=${1:-1}
#input=${2:-syn_ar-en.solr}
output=${2:-input-output.txt}
rm $output
rm $output.error
while read line; do
  if [ "$column" == "1" ];then #if empty
      ar=`echo $line | sed -e 's/ *=> */=>/g' | awk -F"=>" '{print $1}'`
      other=`echo $line | sed -e 's/ *=> */=>/g' | awk -F"=>" '{print $2}'`
  else
      ar=`echo $line | sed -e 's/ *=> */=>/g' | awk -F"=>" '{print $2}'`
      other=`echo $line | sed -e 's/ *=> */=>/g' | awk -F"=>" '{print $1}'`
  fi
  # url="http://localhost:3001/search?limit=1"
  # out=`curl -s --request POST $url \
  #   --header 'Content-Type: application/x-www-form-urlencoded' \
  #   --data-urlencode 'fields=[{"name":"Arabic","layers":[]}]' \
  #   --data-urlencode "input=$word" | jq '.hits.total.value'`

  out=`curl -sG "localhost:9200/hq/_search/?size=1" -H 'Content-Type: application/json' --data-urlencode "q=Arabic:\"$ar\""|
            jq '.hits.hits[]._source'`
  ArabicOut=`echo $out | jq '.Arabic' | xargs`
  ArabicNoorOut=`echo $out | jq '.ArabicNoor' | xargs`

  firstToken=`echo $ar | cut -d " " -f1`
  tokenCount=`echo $ar | awk '{print NF}'`

  ar=`echo $ar | xargs`
  echo "($ar)"
  tokenIdArabic=`echo $ArabicOut |tr -d '"'|
    awk -v c=$tokenCount -v ar="$ar" -F" " '{for(i=1; i<=NF; i++) {t=$i; for(j=i+1; j<=c+i-1; j++){t=t" "$j;} if(t==ar || i==NF) {print i; exit}}}'`



  #echo $ArabicOut
  #echo $ArabicNoorOut
  #echo $tokenCount

  tokenArabicNoor=`echo $ArabicNoorOut |tr -d '"'|
            awk -v tokenIdArabic="$((tokenIdArabic))" -v c=$tokenCount -F" " 'BEGIN { ORS=" "; l=0 };{for(i=1; i<=NF; i++) {if(i=='tokenIdArabic') {for(l=c;l>0;l--){print $(i-l+c) } }}}'`

  echo "$ar \t\t $tokenArabicNoor \t\t id:$tokenIdArabic"

  if [ "$column" == "1" ];then #if empty
      out="$tokenArabicNoor => $other"
  else
      out="$other => $tokenArabicNoor"
  fi

  #echo "$ArabicNoorOut (Noor)"

  #out=`curl -s -XGET "localhost:9200/hq/_analyze" -H 'Content-Type: application/json' -d'{"analyzer" : "'$ARG1'","text" : "'"$line"'"}' | jq '.[][].token'|tr -d '"'| awk '{print}' ORS=' ';echo ""`

  #echo $out2; echo ""

  echo "$ar => $other"
  echo $out | tee -a $output
  if [ -z "$tokenArabicNoor" ];then #if empty
        echo $line >> $output.error
        echo ""
  fi
  echo "---"
done
