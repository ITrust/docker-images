# Hadoop Docker

This repository contains *Dockerfile* for setting up a basic Hadoop cluster.
Derived components are:

1. *HDFS*: for running name node and data node
1. *YARN*: for running node manager and resource manager


All images inherit from an *hadoop* alpine based image which provides an hadoop
installation in `/opt/` and provides a way to configure *hadoop* via
environment variables.

## Hadoop configuration

The *hadoop* configuration is controlled via the following environment
variable groups:

1. `CORE_CONF`: affects `/etc/hadoop/core-site.xml`
1. `HDFS_CONF`: affects `/etc/hadoop/hdfs-site.xml`
1. `YARN_CONF`: affects `/etc/hadoop/yarn-site.xml`
1. `HTTPFS_CONF`: affects `/etc/hadoop/httpfs-site.xml`
1. `KMS_CONF`: affects `/etc/hadoop/KMS-site.xml`

*Hadoop* properties by setting an environment variable with the
appropriated prefix in the form `<PREFIX>_<PROPERTY>`.

Due to restriction imposed by `docker` and `docker-compose` on
environment variable names the following substitution are applied to
property names:

* `_` => `.`
* `__` => `_`
* `___` => `-`

Following are some illustratory examples:

* `CORE_CONF_fs_defaultFS`: sets the *fs.defaultFS* property in
`core-site.xml`
* `YARN_CONF_yarn_log___aggregation___enable`: sets the
  *yarn.log-aggregation-enable* property in `yarn-site.xml`



## Hadoop configuration presets

Furthermore the following special environment variables control
configurations presets:

* `MULTIHOMED_NETWORK`: configure the *hadoop* cluster in such a way
  to be reachable from multiple networks, specifically the following
  properties are set:

    In `/etc/hadoop/hdfs-site.xml`:

    * dfs.namenode.rpc-bind-host = 0.0.0.0
    * dfs.namenode.servicerpc-bind-host = 0.0.0.0
    * dfs.namenode.http-bind-host = 0.0.0.0
    * dfs.namenode.https-bind-host = 0.0.0.0
    * dfs.client.use.datanode.hostname = true
    * dfs.datanode.use.datanode.hostname = true

    In `/etc/hadoop/yarn-site.xml`:

    * yarn.resourcemanager.bind-host = 0.0.0.0
    * yarn.nodemanager.bind-host = 0.0.0.0
    * yarn.nodemanager.bind-host = 0.0.0.0

    In `/etc/hadoop/mapred-site.xml`:

    * yarn.nodemanager.bind-host = 0.0.0.0

## Networking

In order for things to run smoothly it's recommended to exploit the
new networking infrastructure of *docker* 1.9. Create a dedicated
*network* for the cluster to run on.

Furthermore is useful to fix the container *name* and the container
*hostname* to the same value. This way every container will able to
resolve itself with the same name as other container.

Lastly is useful to set the *domainname* equal to the name of the
*network* and use *FQDN* to reference the various services.

With the specified setup is possible you'll be able to access the
web-interfaces of the various components without the annoying problem
of unresolved links (provided that you setup a dns solution to resolve
container names and configure static routing if using
*docker-machine*).

## Credits
Hadoop dockerfiles were forked and migrated to alpine OS from https://bitbucket.org/uhopper/hadoop-docker
