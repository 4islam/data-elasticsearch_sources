#!/bin/sh
export LC_ALL=en_US.UTF-8
#output=ar_scripts/persian/outputs/results/$(date +%F"_"%H"-"%M).html
output=./ar_scripts/persian/outputs/comparison/compare_$1.html
outputstats=./ar_scripts/persian/outputs/comparison/stats/compare_$1.stats.txt
echo '<html>
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><style>
  div{white-space: pre;}
  #Q{font-family: 'noorehuda'; font-size: 38px; line-height:1.7em; text-align: justify;}
  #t{color:blue}
  #s{color:red}
</style>
<script type="text/javascript">
  var display="none";
    function toggle_visibility(id) {
      if (id==2) {var css = document.createElement("style");css.type = "text/css";css.innerHTML = "#t { display: none }"}
      else {var css = document.createElement("style");css.type = "text/css";css.innerHTML = "#s { display: none }"}
      document.head.appendChild(css)
    }
</script>
</head>
<body>
<div>Toggle Visiblity: <a style="cursor: pointer" onclick="toggle_visibility(1)">Source</a> | <a style="cursor: pointer" onclick="toggle_visibility(2)">Target</a> </div>
<div id=Q dir="rtl">' > $output
#locale >> $output
dwdiff -s -d" " -w $' <span id="t">' -x $'</span> ' -y $' <span id="s">' -z $'</span> ' ./ar_scripts/persian/original/tokenized_$1.txt ./ar_scripts/persian/outputs/verses_$1.txt >> $output
echo "</div></body></html>" >> $output

if [ $2 = "chrome" ]; then
  open -a "Google Chrome" $output
fi
if [ $2 = "safari" ]; then
  open -a "safari" $output
fi
dwdiff -s -d" " ./ar_scripts/persian/original/tokenized_$1.txt ./ar_scripts/persian/outputs/verses_$1.txt 2> $outputstats
