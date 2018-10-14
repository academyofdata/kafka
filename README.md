# Kafka in Docker
this is a collection of scripts that helps set up an [Apache Kafka](https://kafka.apache.org) cluster also with a user interface that helps visualise partitions, topics and a few other parameters

It is based upon
 * https://github.com/wurstmeister/kafka-docker; https://hub.docker.com/r/wurstmeister/kafka/
 * https://hub.docker.com/r/wurstmeister/zookeeper/
 * https://hub.docker.com/r/nodefluent/kafka-rest/
 * https://hub.docker.com/r/nodefluent/kafka-rest-ui/
 
## Prerequisites
 * [Docker](https://store.docker.com/search?type=edition&offering=community)  
 * [docker-compose](https://docs.docker.com/compose/install/)
## Usage
(the following steps work in a Linux box with bash shell available)

It should start with a 
```
git pull
```
from this repository and once all the files are retrieved a script designed to replace the Kafka Brokers advertised IP with that of the host
```
./fixip.sh
```
Once the IP is replaced one can start a cluster with the following steps
```
docker-compose up -d
```
(first time this is run, it will download a bunch of Docker images, so it will take some time). This is followed by
```
docker-compose scale kafka=3
```
Once this completes there should be 6 containers running (can be checked with ```docker ps```).
We can now make use of producer.sh / consumer.sh to write and read messages to a specific topic. These scripts have been designed as wrappers over the kafka-console-consumer.sh and kafka-console-producer.sh that come with standard Kafka distribution and they will be run in one container (randomly chosen from the three available)

* producer.sh can receive one or two arguments. If one argument is passed; it should be the topic name; if two arguments are passed it will enable keyed messages
 ./producer.sh msg -> will publish messages in the 'msg' topic
 ./producer.sh msg key -> will publish messages in the 'msg' topic, each published message should have the form <key>:<message>
```
./producer.sh msg
```
or
```
./producer.sh msg usekey
```
* consumer.sh only has one argument -> the topic it should read from
```
./consumer.sh msg
```
 
## UI
One of the started containers provides a browser based UI, can be accessed on <hostip>:9000


