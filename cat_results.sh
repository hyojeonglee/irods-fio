#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <path> < all | seqread | randread | seqwrite | randwrite >"
	exit 1
fi

FILE=$1
RES=$2

if [ "$RES" = "all" ] || [ "$RES" = "seqread" ]
then
	echo "-----seqread"
	cat $FILE/seqread | grep 'runt'
fi

if [ "$RES" = "all" ] || [ "$RES" = "randread" ]
then
	echo "-----randread"
	cat $FILE/randread | grep 'runt'
fi

if [ "$RES" = "all" ] || [ "$RES" = "seqwrite" ]
then
	echo "-----seqwrite"
	cat $FILE/seqwrite | grep 'runt'
fi

if [ "$RES" = "all" ] || [ "$RES" = "randread" ]
then
	echo "-----randwrite"
	cat $FILE/randwrite | grep 'runt'
fi
