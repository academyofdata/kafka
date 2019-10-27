#!/bin/bash

LABELS=""

while getopts 'z:m:n:i:l:' opz
do
  case $opz in
    n) NODE=$OPTARG ;;
    m) MACHINE=$OPTARG ;;
    z) ZONE=$OPTARG ;;
    i) BRKID=$OPTARG ;;
    l) LABELS=$OPTARG ;;
  esac
done

gcloud compute instances create ${NODE} --zone ${ZONE} --machine-type ${MACHINE} --maintenance-policy "MIGRATE" --image "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1804-lts" --boot-disk-size "20" --boot-disk-type "pd-standard" --boot-disk-device-name "${NODE}disk" --labels "${LABELS}"
echo "waiting for machine ${NODE} to boot..."
sleep 30
gcloud compute ssh ${NODE} --zone ${ZONE} --command "wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/setup.sh | bash -s -- -i ${BRKID}"

