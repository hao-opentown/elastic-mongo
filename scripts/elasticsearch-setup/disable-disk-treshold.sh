#!/bin/bash
#
# Make sure ES does not rellocate it's shards when it has low disk space.
# 
curl -XPUT ${ES}:9200/_cluster/settings -d '{
    "transient" : {
        "cluster.routing.allocation.disk.threshold_enabled" : false
    }
}'
