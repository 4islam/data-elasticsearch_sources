#!/bin/sh
export LC_ALL=en_US.UTF-8
#output=ar_scripts/persian/outputs/results/$(date +%F"_"%H"-"%M).html
output=ar_scripts/persian/outputs/results/$(date +%F"_"%H).html
echo '<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style>div{white-space: pre;} *{font-family: 'noorehuda'; font-size: 38px; line-height:1.7em; text-align: justify;}</style></head>
<body dir="rtl"><div>' > $output
#locale >> $output
dwdiff -s -d" " -w $' <span style="color:blue">' -x $'</span> ' -y $' <span  style="color:red">' -z $'</span> ' ar_scripts/persian/original/tokenized_100.txt ar_scripts/persian/outputs/verses_100.txt >> $output
echo "</div></body></html>" >> $output
#open -a "safari" $output
open -a "Google Chrome" $output