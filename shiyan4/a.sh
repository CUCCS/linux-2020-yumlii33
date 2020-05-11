#!/bin/bash

dir="./"
quality="100"
size="none"
prefix="none"
suffix="none"
convert="none"
info="none"
while getopts 'd:q:r:t:p:s:cf:' OPT 
do
	case $OPT in
	d)
	dir=$OPTARG
	;;
	q)
	quality=$OPTARG
	;;
	r)
	size=$OPTARG
	;;
	t)
	info=$OPTARG
	;;
	p)
	prefix=$OPTARG
	;;
	s)
	suffix=$OPTARG
	;;
	c)
	convert="1"
	;;
	f)
	file=$OPTARG
	;;
	esac
done
for i in $(find $dir -name $file)
do
	dirname=$(dirname -- "$i")
	filename=$(basename -- "$i")
	extension=".""${filename##*.}"
	filename="${filename%.*}"
	outfile=$filename
	if [ $prefix != "none" ]
	then
		outfile=$prefix$outfile
	fi
	if [ $suffix != "none" ]
	then
		outfile=$outfile$suffix
	fi
	if [ $convert == "1" ]
	then
		extension=".jpg"
	fi
	outfile=$dirname/$outfile$extension

	if [ $size == "none" ]
	then
		size=$(identify $i | awk '{print $3}')
	fi
	convert -quality "$quality" -resize "$size" "$i" "$outfile"
	if [ $info != "none" ]
	then
		text="text 5,5 '"$info"'"
		convert -gravity southeast -fill black -pointsize 16 -draw "$text" "$outfile" "$outfile"
	fi
done
