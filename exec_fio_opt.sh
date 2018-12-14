#!/bin/bash

if [ $# -ne 8 ]
then
	echo "Usage: $0 <name> <direct> <bs> <numjobs> <size> <runtime> <RW> <mntdir>"
	exit 1
fi

HDD_DIR=$8
NAME=$1
DIRECT=$2
BS=$3
NUMJOBS=$4
SIZE=$5
RUN_TIME=$6
RW=$7

RES_DIR=./$NAME.res
if [ ! -d $RES_DIR ]
then
	mkdir $RES_DIR
fi

if [ "$RW" = "read" ]
then
	echo "fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap"
	fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap > $RES_DIR/seqread
fi

if [ "$RW" = "randread" ]
then
	echo "fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap"
	fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap > $RES_DIR/randread
fi

if [ "$RW" = "write" ]
then
	echo "fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap"
	fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap > $RES_DIR/seqwrite
fi

if [ "$RW" = "randwrite" ]
then
	echo "fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap"
	fio --directory=$HDD_DIR --name $NAME --direct=$DIRECT --rw=$RW --bs=$BS --size=$SIZE --numjobs=$NUMJOBS --time_based --runtime=$RUN_TIME --group_reporting --norandommap > $RES_DIR/randwrite
fi

