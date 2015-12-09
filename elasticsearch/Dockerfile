FROM elasticsearch:latest
MAINTAINER haozi <hao@opentown.cn>

# 
# Elasticsearch with Marvel (monitoring tool)
# Open:
# http://localhost:9200/_plugin/marvel/
#
RUN /usr/share/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

#
# Add Chinese tokenizer support by using jieba.
#
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends git \
  && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/hao-opentown/huaban-es-plugin-targets.git /tmp/huaban-es-plugin-targets
RUN mv /tmp/huaban-es-plugin-targets/0.0.4 /usr/share/elasticsearch/plugins/jieba