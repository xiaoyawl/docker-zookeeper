#!/bin/bash
#########################################################################
# File Name: entrypoint.sh
# Author: LookBack
# Email: admin#dwhd.org
# Version:
# Created Time: 2016年10月18日 星期二 00时19分35秒
#########################################################################

MYID=${MYID:-1}
TICK_TIME=${TICK_TIME:-2000}
INIT_LIMIT=${INIT_LIMIT:-10}
SYNC_LIMIT=${SYNC_LIMIT:-5}
Z_DATA_DIR=${Z_DATA_DIR:-/tmp/zookeeper}
CLIENT_PORT=${CLIENT_PORT:-2181}
MAX_CLIENT_CNXNS=${MAX_CLIENT_CNXNS:-0}
AUTO_PURGE_SNAP_RETAIN_COUNT=${AUTO_PURGE_SNAP_RETAIN_COUNT:-3}
AUTO_PURGE_PURGE_INTERVAL=${AUTO_PURGE_PURGE_INTERVAL:-5}
DATA_LOG_DIR=${DATA_LOG_DIR:-/tmp/zookeeper/logs}
CLUSTER_PORT1=${CLUSTER_PORT1:-2888}
CLUSTER_PORT2=${CLUSTER_PORT2:-3888}

edit_zoo_conf() {
	# based on https://github.com/apache/zookeeper/blob/trunk/conf/zoo_sample.cfg
	echo "${MYID:-1}" > /tmp/zookeeper/myid
	cat > /opt/zookeeper/conf/zoo.cfg <<-EOF
		tickTime=${TICK_TIME}
		initLimit=${INIT_LIMIT}
		syncLimit=${SYNC_LIMIT}
		dataDir=${Z_DATA_DIR}
		clientPort=${CLIENT_PORT}
		maxClientCnxns=${MAX_CLIENT_CNXNS}
		autopurge.snapRetainCount=${AUTO_PURGE_SNAP_RETAIN_COUNT}
		autopurge.purgeInterval=${AUTO_PURGE_PURGE_INTERVAL}
		dataLogDir=${DATA_LOG_DIR}
	EOF
	[ -n "$SERVERS" ] && printf '%s' "$SERVERS" | awk 'BEGIN{RS=","};{printf "server.%i=%s:'"$CLUSTER_PORT1"':'"$CLUSTER_PORT2"'\n", NR, $0}' >> /opt/zookeeper/conf/zoo.cfg
}

[[ ! ${AUTO_EDIT_CONF} =~ ^[dD][iI][sS][aA][bB][lL][eE] ]] && edit_zoo_conf
exec "$@"
