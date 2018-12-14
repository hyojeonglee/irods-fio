#!/bin/bash

#if [ $# -ne 1 ]
#then
#	echo "Usage: $0 <workload>"
#	exit 1
#fi

#WORKLOAD=$1
LBX=$HOME/lazybox

cd $LBX
NSEC=`date +%s%N`
echo "[HJLEE] Start drop cache"
#expect remote_cmds.exp hduser sdc-node11 22 dcslab \
#	"EXEC_MEMORY=29g EXEC_CORES=4 /home/hduser/spark-bench-legacy/$WORKLOAD/bin/run.sh" 3
echo "[HJLEE] Restart sdc 11..."
expect remote_cmds.exp irods sdc-node11 22 irods "/home/irods/drop_cache_and_restart_irods.sh" 1

sleep 10s
echo "[HJLEE] FINISH"
echo "[HJLEE] Restart sdc 16..."
expect remote_cmds.exp irods sdc-node16 22 irods "/home/irods/drop_cache_and_restart_irods.sh" 1

sleep 1s
echo "[HJLEE] FINISH"
echo "[HJLEE] Drop cache localhost..."
sudo /home/irods/drop_cache.sh 

echo "[HJLEE] Complete drop cache, runtime: "$(((`date +%s%N` - $NSEC) / 1000 / 1000))
