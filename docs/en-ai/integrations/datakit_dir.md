---
skip: 'reason: Not part of the integration document'
---

# DataKit Catalog

## Windows

Installation directory: `C:\Program Files\datakit`

Log directory: `C:\Program Files\datakit`

## Linux/MacOS

Installation directory: `/usr/local/datakit`

Log directory: `/var/log/datakit`

## Logs

Under the log directory, there are mainly two files: `gin.log` and `log`

- `gin.log`: This is the access log file, which records external access to DataKit, excluding GRPC.
- `log`: This is the DataKit runtime log file, primarily recording the startup and operational status of collectors as well as data reporting information.

## Collectors

The collector directory is `conf.d`, which contains over 200 built-in collector configurations. For example, the `conf.d/db` directory includes more than ten types of database collector configurations; `conf.d/host` also has a dozen host-related collectors.

Among these, `conf.d/datakit.conf` is the main configuration file for the DataKit collector, including settings related to token, global tags, resources, API, etc.