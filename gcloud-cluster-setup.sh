#!/bin/bash
NODE=kafka01
ZONE=europe-west3-c
MACHINE=n1-standard-1

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE} -z ${ZONE} -m ${MACHINE} -i 1 -l "zookeeper=true"

#start the second node
#get the internal IP of the first node to use as Zookeeper IP
ZKIP=$(gcloud compute instances list --filter labels.zookeeper=true --format="value(networkInterfaces[0].networkIP)")

NODE=kafka02

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE} -z ${ZONE} -m ${MACHINE} -i 2 -k ${ZKIP}

NODE=kafka03

wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/gcloud-setup.sh | bash -s -- -n ${NODE} -z ${ZONE} -m ${MACHINE} -i 3 -k ${ZKIP}
