FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y curl && apt-get install  -y apt-transport-https ca-certificates

ADD cloudera.list /etc/apt/sources.list.d/

RUN curl -o archive.key https://archive.cloudera.com/cdh6/6.3.2/ubuntu1604/apt/archive.key \
    && apt-key add archive.key \
    && apt-key update \
    && apt-get update
    

RUN apt-get install -y hadoop-hdfs-namenode \
    hadoop-hdfs-datanode hive hive-metastore \
    impala impala-catalog impala-server \
    impala-state-store impala-shell \
    kudu-master kudu-tserver \
    rsyslog

COPY ./etc /etc/cdh/
COPY ./default/impala /etc/default/impala

RUN echo "Configuring Hadoop, Hive and Impala" \
 && ln -sf /etc/cdh/core-site.xml /etc/hadoop/conf/  \
 && ln -sf /etc/cdh/hdfs-site.xml /etc/hadoop/conf/  \
 && ln -sf /etc/cdh/hive-site.xml /etc/hive/conf/  \
 && ln -sf /etc/cdh/hdfs-site.xml /etc/impala/conf/  \
 && ln -sf /etc/cdh/core-site.xml /etc/impala/conf/  \
 && ln -sf /etc/cdh/hive-site.xml /etc/impala/conf/  \
 && mkdir -p /var/run/hdfs-sockets \
 && chown hdfs:hadoop /var/run/hdfs-sockets \
 && echo "Formatting HDFS..." \
 && service hadoop-hdfs-namenode init \
 && echo "--use_hybrid_clock=false" >> /etc/kudu/conf/master.gflagfile \
 && echo "--default_num_replicas=1" >> /etc/kudu/conf/master.gflagfile \
 && echo "--use_hybrid_clock=false" >> /etc/kudu/conf/tserver.gflagfile \
 && echo "Creating Hive Meatadata DB schema" \
 && /usr/lib/hive/bin/schematool -dbType derby -initSchema \
 && chown -R hive:hive /var/lib/hive \
 && echo "Fixing problem with lost TZ data" \
 && apt-get install --reinstall tzdata

VOLUME /var/lib/hadoop-hdfs /var/lib/hive /var/lib/impala /var/lib/kudu

EXPOSE 7050 7051 8050 8051 21000 21050 25000 25010 25020

COPY ./docker-entrypoint.sh /usr/local/bin/

RUN ["chmod","+x","/usr/local/bin/docker-entrypoint.sh"]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
