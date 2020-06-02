# Kudu/Impala container from CDH6 stack (6.3.2)

This is a standalone container which has Apache Kudu and Impala installed with dependencies (HDFS, Hive).
Impala: 3.2.0-cdh6.3.2
Kudu: 1.10.0-cdh6.3.2

## Build container

Run inside it's directory:
```shell
docker build . -t fedormalyshkin/chd6-impala-kudu:6.3.2
```

## Run container

```shell
docker run -d -p 8050:8050 -p 8051:8051 -p 21000:21000 -p 21050:21050 -p 25000:25000 -p 25010:25010 -p 25020:25020 -p 50070:50070  -p 50075:50075 --name cdh6-impala-kudu fedormalyshkin/chd6-impala-kudu
```

## Exposed ports

* 7050 [EXT] - Apache Kudu. TabletServer. Kudu TabletServer RPC 
* 7051 [EXT] - Apache Kudu. Master. Kudu Master RPC port
* 8020 [INT] - Apache Hadoop HDFS. NameNode. fs.defaultFS
* 8050 [EXT] - Apache Kudu. TabletServer. Kudu TabletServer HTTP server port
* 8051 [EXT] - Apache Kudu. Master. Kudu Master HTTP server port
* 9083 [INT] - Apache Hive. Metastore. 
* 21000 [EXT] - Apache Impala. Impala Daemon. Used to transmit commands and receive results by impala-shell and version 1.2 of the Cloudera ODBC driver.
* 21050 [EXT] - Apache Impala. Impala Daemon. Used to transmit commands and receive results by applications, such as Business Intelligence tools, using JDBC, the Beeswax query editor in Hue, and version 2.0 or higher of the Cloudera ODBC driver.
* 22000 [INT] - Apache Impala. Impala Daemon. Internal use only. Impala daemons use this port to communicate with each other.
* 23000 [INT] - Apache Impala. Impala Daemon. Internal use only. Impala daemons listen on this port for updates from the statestore daemon.
* 23020 [INT] - Apache Impala. Catalog Daemon. Internal use only. The catalog daemon listens on this port for updates from the statestore daemon. 
* 24000 [INT] - Apache Impala. StateStore Daemon. Internal use only. The statestore daemon listens on this port for registration/unregistration requests.
* 25000 [EXT] - Apache Impala. Impala Daemon. Impala web interface for administrators to monitor and troubleshoot.
* 25010 [EXT] - Apache Impala. StateStore Daemon. StateStore web interface for administrators to monitor and troubleshoot. 
* 25020 [EXT] - Apache Impala. Catalog Daemon. Catalog service web interface for administrators to monitor and troubleshoot.
* 26000 [INT] - Apache Impala. Catalog Daemon. Internal use only. The catalog service uses this port to communicate with the Impala daemons.
* 50010 [INT] - Apache Hadoop HDFS. DataNode. dfs.datanode.address

## Reference data for ports:

* [CDH Ports](https://docs.cloudera.com/documentation/enterprise/latest/topics/cm_ig_ports.html)

