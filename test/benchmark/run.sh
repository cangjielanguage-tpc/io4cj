#!/bin/bash
path=`pwd`
i=0
for file in ${path}/*
do
	temp_file=`basename $file`
	# str=$1
	str="TestSuite"
	if [[ $temp_file =~ $str ]];then
		echo $temp_file
		cjtest $temp_file --bench
		if [[ $i == 0 ]];then
			((i++))
			cat report/perf.csv >> reportALL/perfALL.csv
		else
			awk 'NR>=2{print}' report/perf.csv >> reportALL/perfALL.csv
		fi
	fi
done