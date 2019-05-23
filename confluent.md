In order to set-up Confluent Platform on a single machine execute confluent.sh on a "fresh" Debian or Ubuntu installation (for RedHat/CentOS systems replace apt-get with the corresponding yum commands)

One can also do something like
```
wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/confluent.sh | bash
```
The pre-packaged version of Confluent comes with data-gen installed, otherwise these steps need to be followed

```
sudo apt-get update
sudo apt-get install -y jq
cd /opt/confluent
bin/confluent-hub install confluentinc/kafka-connect-datagen:latest
bin/confluent stop connect
bin/confluent start connect
bin/confluent list plugins
```
