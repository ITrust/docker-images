## About:

[Docker](http://www.docker.com/) image based on [digitalwonderland/docker-kafka](https://registry.hub.docker.com/u/digitalwonderland/docker-kafka/) and [Confluent](http://www.confluent.io/)

## Additional Software:

* [Apache Kafka Rest Proxy](http://www.confluent.io/product)

## Usage:

The image provides a REST proxy to Kafka brokers. It depends on Zookeeper and Kafka-schema-registry

As a minimum the following environment variables should be set:

1. ```RP_SCHEMA_REGISTRY_URL``` (default: http://kafka-schema:9081)
2. ```RP_ZOOKEEPER_CONNECT``` (default: zookeeper:2181)

### Additional configuration

can be provided via environment variables starting with ```RP_```. Any matching variables will get added to confluent's ```kafka-rest.properties``` by

1. removing the ```RP_``` prefix
2. transformation to lower case
3. replacing any occurences of ```_``` with ```.```
