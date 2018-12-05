#!/bin/sh
export LC_ALL=en_US.UTF-8
#output=ar_scripts/persian/outputs/results/$(date +%F"_"%H"-"%M).html
output=./persian/outputs/results/compare_$1.html
outputstats=./persian/outputs/compare_$1.stats.txt
echo '<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style>div{white-space: pre;} *{font-family: 'noorehuda'; font-size: 38px; line-height:1.7em; text-align: justify;}</style></head>
<body dir="rtl"><div>' > $output
#locale >> $output
dwdiff -s -d" " -w $' <span style="color:blue">' -x $'</span> ' -y $' <span  style="color:red">' -z $'</span> ' ./persian/original/tokenized_$1.txt ./persian/outputs/verses_$1.txt >> $output
echo "</div></body></html>" >> $output
if [ -z "$2" ]; then
  #open -a "safari" $output
  open -a "Google Chrome" $output
fi
dwdiff -s -d" " ./persian/original/tokenized_$1.txt ./persian/outputs/verses_$1.txt 2> $outputstats
