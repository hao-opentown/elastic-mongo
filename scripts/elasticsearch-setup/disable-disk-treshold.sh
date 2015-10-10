#!/bin/bash
#
# Make sure ES does not rellocate it's shards when it has low disk space.
# 
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

curl -XPUT ${ES}:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'
