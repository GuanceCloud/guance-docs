# DataKit directory

## Windows

Installation directory:`C:\Program Files\datakit`

Log directory:`C:\Program Files\datakit`

## Linux/MacOS

Installation directory:`/usr/local/datakit`

Log directory:`/var/log/datakit`

## Log

There are two main files in the log directory: `gin.log` and `log`.

- `gin.log` ：It is an access log file, which is the log record of external access to DataKit and does not include GRPC.
- `log`：It is a DataKit running log file that mainly records the startup and running status of the collector, as well as data reporting information.

## Collector


The collector directory is `conf.d`, which contains over 200 types of collector configurations. For example, the `conf.d/db` directory contains more than 10 types of database collector configurations `conf.d/host` also has over a dozen types of host related collectors.

Among them, `conf.d/datakit.conf` is the configuration related to the DataKit main collector, such as tokens, global tags, resources, APIs, and other related configurations.

