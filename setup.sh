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
cd ${WORKDIR}
#start zookeeper
#the default config listens on _all_ interfaces so we can replace later on with the internal ip instead of localhost
echo "starting Zookeeper..."
bin/zookeeper-server-start.sh config/zookeeper.properties >> zookeeper.log 2>&1 &
ZKIP=$(hostname --ip-address)
echo "replacing ZK IP ..."
sed -i "s/localhost:2181/${ZKIP}:2181/g" config/server.properties

