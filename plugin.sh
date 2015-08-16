curl -X<VERB> '<PROTOCOL>://<HOST>/<PATH>?<QUERY_STRING>' -d '<BODY>'
curl 'http://localhost:9200/?pretty'
curl -i  -XGET 'http://localhost:9200/_count?pretty' -d '
{
    "query": {
        "match_all": {}
    }
}
'

curl -i -XGET 'localhost:9200/'
##################### Plugins  #####################
cd /usr/share/elasticsearch/bin
./plugin -install mobz/elasticsearch-head
./plugin -install lukas-vlcek/bigdesk 
Plugins can be copied under the plugins directory, 
or using the plugin script. 
head and bigdesk can be renamed

http://localhost:9200/_plugin/head/
http://localhost:9200/_plugin/bigdesk/

elasticsearch-head是一个elasticsearch的集群管理工具，
它是完全由html5编写的独立网页程序，你可以通过插件把它集成到es。

bigdesk是elasticsearch的一个集群监控工具，
可以通过它来查看es集群的各种状态，
如：cpu、内存使用情况，索引数据、搜索情况，http连接数等。

##################### Shield  #####################
Installing Shield on Offline Machines
https://download.elastic.co/elasticsearch/shield/shield-1.3.2.zip
bin/plugin -i shield -u file://PATH_TO_ZIP_FILE

./bin/shield/esusers useradd ky -p abc123Abc
./bin/shield/esusers list
./bin/shield/esusers passwd ky -p abc123AbC
