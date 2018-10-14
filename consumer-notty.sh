#!/bin/bash
broker=$(docker ps | grep start-kafka | shuf | head -1 | awk '{print $1}')
brokerip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $broker)
echo "executing kafka-console-consumer on ${broker} which has address ${brokerip}"
docker exec -i ${broker} bash -c "kafka-console-consumer.sh --bootstrap-server ${brokerip}:9092 --from-beginning --topic $1"
