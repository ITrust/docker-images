## About:

[Docker](http://www.docker.com/) image based on [digitalwonderland/docker-kafka](https://registry.hub.docker.com/u/digitalwonderland/docker-kafka/)

## Additional Software:

* [Apache Kafka](http://kafka.apache.org/)

## Usage:

The image provides a clusterable Kafka broker.

As a minimum the following environment variables must be set:

1. ```KAFKA_BROKER_ID```
2. ```KAFKA_ADVERTISED_HOST_NAME```
3. ```KAFKA_ZOOKEEPER_CONNECT```

So, assuming your Docker host is ```172.17.8.101```, has [Zookeeper](http://zookeeper.apache.org/) running and should now run Kafka as well, execute the following:

```
docker run -d -e KAFKA_BROKER_ID=1 -e KAFKA_ADVERTISED_HOST_NAME=172.17.8.101 -e KAFKA_ZOOKEEPER_CONNECT=172.17.8.101 digitalwonderland/kafka
```

(if you are looking for a clusterable Zookeeper Docker image, feel free to use [itrust/zookeeper](https://github.com/itrust/docker-images))

### Additional configuration

can be provided via environment variables starting with ```KAFKA_```. Any matching variables will get added to Kafkas ```server.properties``` by

1. removing the ```KAFKA_``` prefix
2. transformation to lower case
3. replacing any occurences of ```_``` with ```.```

For example an environment variable ```KAFKA_NUM_PARTITIONS=3``` will result in ```num.partitions=3``` within ```server.properties```.
