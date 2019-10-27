#!/bin/bash
NODE=kafka01
ZONE=europe-west3-c
MACHINE=n1-standard-1



gcloud compute instances create ${NODE} --zone ${ZONE} --machine-type ${MACHINE} --maintenance-policy "MIGRATE" --image "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "${NODE}disk" --labels "zookeeper=true"
echo "waiting for machine ${NODE} to boot..."
sleep 30
gcloud compute ssh ${NODE} --zone ${ZONE} --command "wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/setup.sh | bash -s -- -i 1"

#start the second node
#get the internal IP of the first node to use as Zookeeper IP
ZKIP=$(gcloud compute instances list --filter="name=${NODE}" --format="value(networkInterfaces[0].networkIP)")

NODE=kafka02

gcloud compute instances create ${NODE} --zone ${ZONE} --machine-type ${MACHINE} --maintenance-policy "MIGRATE" --image "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "${NODE}disk" 
echo "waiting for machine ${NODE} to boot..."
sleep 30
gcloud compute ssh ${NODE} --zone ${ZONE} --command "wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/setup.sh | bash -s -- -i 2 -z ${ZKIP}"

NODE=kafka03

gcloud compute instances create ${NODE} --zone ${ZONE} --machine-type ${MACHINE} --maintenance-policy "MIGRATE" --image "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "${NODE}disk" 
echo "waiting for machine ${NODE} to boot..."
sleep 30
gcloud compute ssh ${NODE} --zone ${ZONE} --command "wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/setup.sh | bash -s -- -i 3 -z ${ZKIP}"
