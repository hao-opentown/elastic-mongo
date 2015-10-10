#! /bin/bash
#
# warning: clean the index.
#

ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
INDEX_NAME=opentown

curl -XDELETE ${ES}:9200/${INDEX_NAME}

curl -XPUT ${ES}:9200/${INDEX_NAME} -d '
{
    "index":{
        "number_of_shards":1,
        "number_of_replicas":0,
        "analysis":{
            "analyzer":{
                "jieba_search":{
                    "type":"jieba",
                    "seg_mode":"search",
                    "stop":true
                },
                "jieba_other":{
                    "type":"jieba",
                    "seg_mode":"other",
                    "stop":true
                },
                "jieba_index":{
                    "type":"jieba",
                    "seg_mode":"index",
                    "stop":true
                }
            }
        }
    }
}'

# 
# what's the strategy to search phone field?
#
curl -XPUT ${ES}:9200/${INDEX_NAME}/_mapping/users -d '
{
    "users":{
        "properties":{
            "nickname":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "intro":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "phone":{
                "type":"string"
            },
            "deleted" : {
                "type" : "boolean"
            }
        }
    }
}'


curl -XPUT ${ES}:9200/${INDEX_NAME}/_mapping/topics -d '
{
    "topics":{
        "properties":{
            "title":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "abstract":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "statements":{
                "properties":{
                    "content" : {
                        "type":"string",
                        "analyzer":"jieba_index"
                    }
                }
            },
            "deleted" : {
                "type" : "boolean"
            }
        }
    }
}'

#
# verify the index information
#

curl -XGET ${ES}:9200/${INDEX_NAME}


