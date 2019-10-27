#!/bin/bash
#install java
sudo apt-get update
sudo apt-get install -y default-jre openjdk-11-jre

ZKIP=$(hostname --ip-address)
BRKID=0
SVRIP=${ZKIP}
ZKSTART=false

while getopts 'z:i:' opz
do
  case $opz in
    z) ZKIP=$OPTARG ;;
    i) BRKID=$OPTARG ;;
  esac
done

#download kafka & zookeeper bundle
KAFKAVER="2.3.0"
SCALAVER="2.12"
WORKDIR="/tmp"

echo "getting archive ..."
wget -q -O ${WORKDIR}/kafka.tgz https://www-eu.apache.org/dist/kafka/${KAFKAVER}/kafka_${SCALAVER}-${KAFKAVER}.tgz 
mkdir -p ${WORKDIR}/kafka
echo "expanding..."
tar -C ${WORKDIR}/kafka --strip-components 1 -xzf ${WORKDIR}/kafka.tgz
cd ${WORKDIR}/kafka
if [ "${ZKIP}" = "${SVRIP}" ] ; then
    #no zookeeper ip was provided, we start our own locally
    #the default config listens on _all_ interfaces 
    echo "starting Zookeeper..."
    bin/zookeeper-server-start.sh config/zookeeper.properties >> zookeeper.log 2>&1 &
fi

echo "starting kafka broker..."
bin/kafka-server-start.sh config/server.properties --override advertised.listeners=PLAINTEXT://${SVRIP}:9092 --override broker.id=${BRKID} --override zookeeper.connect=${ZKIP}:2181 >> kafka.log 2>&1 &


