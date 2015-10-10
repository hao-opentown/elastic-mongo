#! /bin/bash
#
# warning: clean the index.
#
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
    "user":{
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
                "type" : "integer"
            }
        }
    }
    
}'


curl -XPUT ${ES}:9200/${INDEX_NAME}/_mapping/topics -d '
{
    "topic":{
        "properties":{
            "title":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "abstract":{
                "type":"string",
                "analyzer":"jieba_index"
            },
            "statements":[
                {
                    "type":"string",
                    "analyzer":"jieba_index"
                }
            ],
            "deleted" : {
                "type" : "integer"
            }
        }
    }
}'

#
# verify the index information
#

curl -XGET ${ES}:9200/${INDEX_NAME}


