#!/bin/bash
all=$(sed '1d' web_log.tsv | wc -l)
echo "top 100 host"
sed '1d' web_log.tsv | awk -F'\t' '{print $1}' | sort -h | uniq -c | sort -hr | head -n 100

echo "top 100 ip"
sed '1d' web_log.tsv |\
	    awk -F'\t' '{print $1}' |\
	    grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" |\
	    sort -h |\
	    uniq -c |\
	    sort -hr |\
	    head -n 100

echo "top 100 url"
sed '1d' web_log.tsv | awk -F'\t' '{print $5}' | sort -h | uniq -c | sort -hr | head -n 100

echo "response code"
sed '1d' web_log.tsv | awk -F'\t' '{print $6}' | sort -h | uniq -c | sort -hr | head -n 100 | awk -v a="$all" '{pc=100*$1/a"%"; print pc,$1,$2}'

for i in $(seq 400 451)
do
	sed '1d' web_log.tsv | awk -F'\t' '{print $6,$5}' | grep "^$i" | sort | uniq -c | sort -hr | head -n 100
done

echo ""
echo "url top 100 host"
sed '1d' web_log.tsv | grep "$1" |awk -F'\t' '{print $1,$5}' | sort | uniq -c | sort -hr | head -n 100
