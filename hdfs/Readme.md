# Hadoop HDFS Docker

All images inherit from an *hadoop* alpine based image which provides an hadoop
installation in `/opt/` and provides a way to configure *hadoop* via
environment variables.

## Credits
Hadoop dockerfiles were forked and migrated to alpine OS from https://bitbucket.org/uhopper/hadoop-docker

## Components

### namenode

The *hdfs* image starts an Hadoop NameNode by running the `run-namenode.sh` script. (single instance)

Additional environment variables:

* `CLUSTER_NAME`: name of the *HDFS* cluster (used during the initial
formatting)

Volumes:

* `/hadoop/dfs/name`: *HDFS* filesystem name directory

Mandatory configuration:

* `CLUSTER_NAME`: cluster name

*Docker-compose* template:

    namenode:
      image: itrust/hdfs
      hostname: namenode
      container_name: namenode
      domainname: hadoop
      net: hadoop
      command: /run-namenode.sh
      volumes:
        - <NAMENODE-VOLUME>:/hadoop/dfs/name
      environment:
        - CLUSTER_NAME=<CLUSTER-NAME>

Once running you can connect to `http://<CONTAINER_IP>:50070` to see
the webui.

### datanode

The *hdfs* image starts an Hadoop DataNode bu running the `run-datanode.sh` script. (multiple instances)

Volumes:

* `/hadoop/dfs/data`: *HDFS* filesystem data directory

Mandatory configuration:

* `CORE_CONF_fs_defaultFS`: *HDFS* address (i.e. `hdfs://<NAMENODE-HOST>:8020`)

*Docker-compose* template:

    datanode1:
      image: itrust/hdfs
      hostname: datanode1
      container_name: datanode1
      domainname: hadoop
      net: hadoop
      command: /run-datanode.sh
      volumes:
        - <DATANODE-VOLUME>:/hadoop/dfs/data
      environment:
        - CORE_CONF_fs_defaultFS=hdfs://<NAMENODE-HOST>:8020
