In order to set-up Confluent Platform on a single machine follow copy steps in a .sh file and execute them on a "fresh" Debian or Ubuntu installation (for RedHat/CentOS systems replace apt-get with the corresponding yum commands)
```
sudo apt-get update
sudo apt-get install -y openjdk-8-jre
CONFLUENT_VER="5.2.1"
SCALA_VER="2.12"
#http://packages.confluent.io/archive/5.2/confluent-5.2.1-2.12.zip
wget http://packages.confluent.io/archive/5.2/confluent-${CONFLUENT_VER}-${SCALA_VER}.tar.gz -O /tmp/confluent.tar.gz
cd /tmp
tar -xzf ./confluent.tar.gz
sudo mv ./confluent-${CONFLUENT_VER} /opt/confluent
cd /opt/confluent
bin/confluent start

#download the data files
ODIR="/tmp"
wget https://raw.githubusercontent.com/academyofdata/data/master/movies-with-year.csv -O $ODIR/movies.csv
wget https://raw.githubusercontent.com/academyofdata/inputs/master/ratings2.csv -O $ODIR/ratings_s.csv
wget https://raw.githubusercontent.com/academyofdata/inputs/master/ratings.csv.gz -O $ODIR/ratings.csv.gz
gunzip -f $ODIR/ratings.csv.gz
wget https://raw.githubusercontent.com/academyofdata/data/master/users.csv -O $ODIR/users.csv

#load them in kafka using kafka-console-producer
bin/kafka-console-producer --topic users --broker-list localhost:9092 < /tmp/users.csv
bin/kafka-console-producer --topic movies --broker-list localhost:9092 < /tmp/movies.csv
bin/kafka-console-producer --topic ratings_s --broker-list localhost:9092 < /tmp/ratings_s.csv
bin/kafka-console-producer --topic ratings --broker-list localhost:9092 < /tmp/ratings.csv
```
