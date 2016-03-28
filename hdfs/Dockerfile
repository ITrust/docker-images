FROM itrust/hadoop:2.7.1
MAINTAINER Maxime Cottret <mcottret@itrust.fr>

# env for namenode
ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD run-namenode.sh /run-namenode.sh
RUN chmod a+x /run-namenode.sh

# env for datanode
ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run-datanode.sh /run-datanode.sh
RUN chmod a+x /run-datanode.sh
