#!/bin/bash

if [ $# -ne 7 ]
then
	echo "Usage: $0 <name> <direct> <bs> <numjobs> <size> <runtime> <mntdir>"
	exit 1
fi

RT_DIR=/home/irods/irods-fio

HDD_DIR=$7
NAME=$1
DIRECT=$2
BS=$3
NUMJOBS=$4
SIZE=$5
RUN_TIME=$6

RES_DIR=$RT_DIR/$NAME.res
if [ ! -d $RES_DIR ]
then
	mkdir $RES_DIR
fi

echo "[RUN-ONELINE] Start..."
echo "NAME=$NAME DIRECT=$DIRECT BS=$BS NUMJOBS=$NUMJOBS SIZE=$SIZE RUN_TIME=$RUN_TIME HDD_DIR=$HDD_DIR"

echo "[RUN-ONELINE] Drop all..."
$RT_DIR/drop_all.sh
sleep 3s

echo "[RUN-ONELINE] Seq write..."
$RT_DIR/exec_fio_opt.sh $NAME $DIRECT $BS $NUMJOBS $SIZE $RUN_TIME write $HDD_DIR
sleep 3s

echo "[RUN-ONELINE] Drop all..."
$RT_DIR/drop_all.sh
sleep 3s

echo "[RUN-ONELINE] Rand write..."
$RT_DIR/exec_fio_opt.sh $NAME $DIRECT $BS $NUMJOBS $SIZE $RUN_TIME randwrite $HDD_DIR
sleep 3s

echo "[RUN-ONELINE] Drop all..."
$RT_DIR/drop_all.sh
sleep 3s

echo "[RUN-ONELINE] Seq read..."
$RT_DIR/exec_fio_opt.sh $NAME $DIRECT $BS $NUMJOBS $SIZE $RUN_TIME read $HDD_DIR
sleep 3s

echo "[RUN-ONELINE] Drop all..."
$RT_DIR/drop_all.sh
sleep 3s

echo "[RUN-ONELINE] Rand read..."
$RT_DIR/exec_fio_opt.sh $NAME $DIRECT $BS $NUMJOBS $SIZE $RUN_TIME randread $HDD_DIR
sleep 3s

echo "[RUN-ONELINE] Drop all..."
$RT_DIR/drop_all.sh
sleep 3s

echo "[RUN-ONELINE] Log final result..."
$RT_DIR/cat_results.sh $RES_DIR all > $RES_DIR/final_result

echo "[RUN-ONELINE] Show final result..."
cat $RES_DIR/final_result

echo "[RUN-ONELINE] COMPLETE!!!"
