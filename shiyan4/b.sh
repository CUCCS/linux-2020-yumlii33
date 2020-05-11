#!/bin/bash

all=$(sed '1d' worldcupplayerinfo.tsv | wc -l)
echo "age:"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '$6 < 20 {print "<20"}; $6 >= 20 && $6<=30 {print "[20,30]"}; $6>30 {print ">30"}' | sort | uniq -c | awk -v a="$all" '{pc=100*$1/a"%"; print pc,$0}'
echo ""

echo "position:"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '{print $5}' | sort | uniq -c | awk -v a="$all" '{pc=100*$1/a"%"; print pc,$0}'

echo ""
echo "the longest name"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '{print length($9),"\t",$9}' | sort -h | tail -n 1 | awk -F'\t' '{print $2}'
echo ""
echo "the shortest name"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '{print length($9),"\t",$9}' | sort -h | head -n 1 | awk -F'\t' '{print $2}'

echo ""
echo "the oldest is"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '{print $6,"\t",$9}' | sort -h | head -n 1 | awk -F'\t' '{print $2}'

echo ""
echo "the youngest is"
sed '1d' worldcupplayerinfo.tsv | awk -F'\t' '{print $6,"\t",$9}' | sort -h | tail -n 1 | awk -F'\t' '{print $2}'
