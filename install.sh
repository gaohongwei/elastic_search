
cd ~
##If you want to install OpenJDK
#sudo apt-get update
#sudo apt-get install openjdk-8-jre-headless -y

apt-get download
###Or if you want to install Oracle JDK, which seems to have slightly better performance
apt-get install software-properties-common -y
add-apt-repository ppa:webupd8team/java -y
apt-get update
apt-get install oracle-java8-installer -y
java -version

### Download java
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  \
http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz
### Check http://www.elasticsearch.org/download/ for latest version of ElasticSearch and replace wget link below

wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.2.deb
sudo dpkg -i elasticsearch-1.4.2.deb

### NOT starting elasticsearch by default on bootup, please execute
 sudo update-rc.d elasticsearch defaults 95 10
### In order to start elasticsearch, execute
 sudo /etc/init.d/elasticsearch start

#To test it all worked:
#curl http://localhost:9200
#Should return some JSON Object including the version number

##################### #####################
### USAGE
###
### ./ElasticSearch.sh 1.5.0 will install Elasticsearch 1.5.0
### ./ElasticSearch.sh 1.4.4 will install Elasticsearch 1.4.4
### ./ElasticSearch.sh will fail because no version was specified (exit code 1)
###
### CLI options Contributed by @janpieper
### Check http://www.elasticsearch.org/download/ for latest version of ElasticSearch

### ElasticSearch version
if [ -z "$1" ]; then
  echo ""
  echo "  Please specify the Elasticsearch version you want to install!"
  echo ""
  echo "    $ $0 1.5.0"
  echo ""
  exit 1
fi
 
ELASTICSEARCH_VERSION=$1
 
if [[ ! "${ELASTICSEARCH_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]]; then
  echo ""
  echo "  The specified Elasticsearch version isn't valid!"
  echo ""
  echo "    $ $0 1.5.0"
  echo ""
  exit 2
fi
 
### Install OpenJDK
cd ~
sudo apt-get update
sudo apt-get install openjdk-7-jre-headless -y

### To install Java 8 instead, uncomment the following two lines  
# sudo update-java-alternatives -s java-8-oracle
# sudo apt-get install oracle-java8-set-default

### Download and Install ElasticSearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.deb
sudo dpkg -i elasticsearch-${ELASTICSEARCH_VERSION}.deb

### Install the Java Service Wrapper for ElasticSearch
curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz
sudo mkdir /usr/local/share/elasticsearch
sudo mkdir /usr/local/share/elasticsearch/bin
sudo mv *servicewrapper*/service /usr/local/share/elasticsearch/bin/
rm -Rf *servicewrapper*
sudo /usr/local/share/elasticsearch/bin/service/elasticsearch install
sudo ln -s `readlink -f /usr/local/share/elasticsearch/bin/service/elasticsearch` /usr/local/bin/rcelasticsearch
 
### Start ElasticSearch 
sudo service elasticsearch start

### Make sure service is running
curl http://localhost:9200

### Should return something like this:
# {
#  "status" : 200,
#  "name" : "Storm",
#  "version" : {
#    "number" : "1.3.1",
#    "build_hash" : "2de6dc5268c32fb49b205233c138d93aaf772015",
#    "build_timestamp" : "2014-07-28T14:45:15Z",
#    "build_snapshot" : false,
#    "lucene_version" : "4.9"
#  },
#  "tagline" : "You Know, for Search"
# }

Locate installation directory ( Look for Settings -> Path -> Home for value )
$ curl "localhost:9200/_nodes/settings?pretty=true"
http://127.0.0.1:9200/_nodes/settings?pretty=true
