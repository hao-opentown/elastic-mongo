#!/bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
ES=`ping -c 1 elasticsearch | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`


/scripts/wait-until-started.sh


echo "================================="
echo "Writing to MongoDB"
mongo ${MONGODB1} <<EOF
  use opentown
  rs.config()
  var p = {nickname: "haozi", phone: "18612341234", intro : "wardering."}
  db.users.save(p)
EOF


echo "================================="
echo "Fetching data from Mongo opentown's users"
echo curl http://${MONGODB1}:28017/opentown/users/?limit=10
curl http://${MONGODB1}:28017/opentown/users/?limit=10

echo "Fetching data from Mongo opentown's topics"
echo curl http://${MONGODB1}:28017/opentown/topics/?limit=10
curl http://${MONGODB1}:28017/opentown/topics/?limit=10
echo "================================="


printf "\nReading from Elasticsearch (waiting for the transporter to start)\n\n"
sleep 40
curl -XGET "http://${ES}:9200/opentown/_search?pretty&q=*:*"


echo "================================="
echo "DONE"
