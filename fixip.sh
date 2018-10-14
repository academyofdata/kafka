#!/bin/bash
hostip=$(hostname -i)
sed -i -r "s/KAFKA_ADVERTISED_HOST_NAME:\s*(.*)/KAFKA_ADVERTISED_HOST_NAME: ${hostip}/g" docker-compose.yml
