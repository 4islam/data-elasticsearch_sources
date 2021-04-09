#!/bin/sh
cat ES/syn_en-ar.solr | ./quran.sh ar_original_noor ES/syn_en-ar_noor.solr
cat ES/syn_ar-en.solr | ./quran.sh ar_original_noor ES/syn_ar-en_noor.solr
cat ES/uniq_en-ar.txt | ./quran.sh ar_original_noor ES/uniq_en-ar_noor.txt
#cat ES/uniq_ar-en.txt | ./quran.sh ar_original_noor ES/uniq_ar-en_noor.txt
