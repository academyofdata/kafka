In order to set-up Confluent Platform on a single machine execute confluent.sh on a "fresh" Debian or Ubuntu installation (for RedHat/CentOS systems replace apt-get with the corresponding yum commands)

One can also do something like
```
wget -qO- https://raw.githubusercontent.com/academyofdata/kafka/master/confluent.sh | bash
```
The pre-packaged version of Confluent comes with data-gen installed, otherwise these steps need to be followed

```
sudo apt-get update
cd /opt/confluent
bin/confluent-hub install confluentinc/kafka-connect-datagen:latest
bin/confluent stop connect
bin/confluent start connect
bin/confluent list plugins
```

In order to populate the topics we need for our course we will then run

```
apt-get update && apt-get install -y jq
cd /opt/confluent
wget -q -O /tmp/ratings.avro https://raw.githubusercontent.com/academyofdata/data/master/ratings.avro
wget -q -O /tmp/rsvps.json https://raw.githubusercontent.com/academyofdata/data/master/rsvps.json
jq -c -r '{city: .group.group_city, country: .group.group_country, member:.member.member_id, id:.rsvp_id,event_id:.event.event_id, topix:.group.group_topics[0]}' /tmp/rsvps.json |  bin/kafka-console-producer --topic meetux --broker-list localhost:9092
sed "s/\"group\"/\"groupx\"/i" /tmp/rsvps.json |  bin/kafka-console-producer --topic rsvpx --broker-list localhost:9092
```
