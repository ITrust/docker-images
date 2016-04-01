## About:

[Docker](http://www.docker.com/) image based on [digitalwonderland/docker-kafka](https://registry.hub.docker.com/u/digitalwonderland/docker-kafka/)  and [Confluent](http://www.confluent.io/)

## Additional Software:

* [Apache Kafka](http://kafka.apache.org/)

## Usage:

The image provides a clusterable Kafka broker.

As a minimum the following environment variables should be set:

1. ```KAFKA_BROKER_ID``` (default: 0)
2. ```KAFKA_ADVERTISED_HOST_NAME``` (default: container ip)
3. ```KAFKA_ZOOKEEPER_CONNECT``` (default: zookeeper)

So, assuming your Docker host is ```172.17.8.101```, has [Zookeeper](http://zookeeper.apache.org/) running on ```ZOOKEEPER_IP``` and should now run an additional Nth Kafka broker , execute the following:

```
docker run -d -e KAFKA_BROKER_ID=N -e KAFKA_ADVERTISED_HOST_NAME=172.17.8.101 -e KAFKA_ZOOKEEPER_CONNECT=ZOOKEEPER_IP itrust/kafka
```

(if you are looking for a clusterable Zookeeper Docker image, feel free to use [itrust/zookeeper](https://github.com/itrust/docker-images))

### Additional configuration

can be provided via environment variables starting with ```KAFKA_```. Any matching variables will get added to Kafkas ```server.properties``` by

1. removing the ```KAFKA_``` prefix
2. transformation to lower case
3. replacing any occurences of ```_``` with ```.```

For example an environment variable ```KAFKA_NUM_PARTITIONS=3``` will result in ```num.partitions=3``` within ```server.properties```.
