#!/bin/bash
#install java
sudo apt-get update
sudo apt-get install -y default-jre

#download kafka & zookeeper bundle
KAFKAVER="2.3.0"
SCALAVER="2.12"
WORKDIR="/tmp"

echo "getting archive ..."
wget -q -O ${WORKDIR}/kafka.tgz https://www-eu.apache.org/dist/kafka/${KAFKAVER}/kafka_${SCALAVER}-${KAFKAVER}.tgz 
mkdir -p ${WORKDIR}/kafka
echo "expanding..."
tar -C ${WORKDIR}/kafka --strip-components 1 -xzf ${WORKDIR}/kafka.tgz
SVRIP=$(hostname --ip-address)
cd ${WORKDIR}

