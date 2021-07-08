#!/bin/bash
NODE=kafka0
ZONE=europe-west3-c
MACHINE=n1-standard-1
INDEX=1

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE}${INDEX} -z ${ZONE} -m ${MACHINE} -i ${INDEX} -l "zookeeper=true"

#start the second node
#get the internal IP of the first node to use as Zookeeper IP
ZKIP=$(gcloud compute instances list --filter labels.zookeeper=true --format="value(networkInterfaces[0].networkIP)")

INDEX=2

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE}${INDEX} -z ${ZONE} -m ${MACHINE} -i ${INDEX} -k ${ZKIP}

INDEX=3

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE}${INDEX} -z ${ZONE} -m ${MACHINE} -i ${INDEX} -k ${ZKIP}
