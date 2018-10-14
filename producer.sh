#!/bin/bash
broker=$(docker ps | grep start-kafka | shuf | head -1 | awk '{print $1}')
brokerip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $broker)
echo "executing kafka-console-producer on ${broker} which has address ${brokerip}"
docker exec -ti ${broker} bash -c "kafka-console-producer.sh --broker-list ${brokerip}:9092 --topic $1"
