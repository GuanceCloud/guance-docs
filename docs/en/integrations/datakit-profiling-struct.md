---
skip: 'not-searchable-on-index-page'
title: 'Datakit Profiling Related Data Structures'
---

This document describes the definitions of profiling-related data structures in Datakit.

## Introduction to Datakit Line Protocol {#line-protocol}

- Line Protocol is the final data that is written to disk.
- The structure of Line Protocol data is a string composed of four parts: Name, Tags, Fields, and Timestamp, separated by commas and spaces, for example:

```line protocol
source_name,key1=value1,key2=value2 field1=value1,field2=value2 ts
```

## Tags and Fields Used in Datakit Profiling Line Protocol {#tags-fields}

| Section | Name               | Unit       | Description                                                   |
|---------|--------------------|------------|---------------------------------------------------------------|
| Tag     | `host`             |            | host name                                                     |
| Tag     | `endpoint`         |            | endpoint of resource                                          |
| Tag     | `service`          |            | service name                                                  |
| Tag     | `env`              |            | environment arguments                                         |
| Tag     | `version`          |            | service version                                               |
| Tag     | `language`         |            | language [`Java`, `Python`, `Golang`, ...]                    |
| Field   | `runtime`          |            | runtime [`jvm`, `CPython`, `go`, ....]                        |
| Field   | `runtime_os`       |            | operating system                                              |
| Field   | `runtime_arch`     |            | CPU architecture                                              |
| Field   | `runtime_version`  |            | programming language version                                  |
| Field   | `runtime_compiler` |            | compiler                                                      |
| Field   | `runtime_id`       |            | unique ID allocated once process bootstrap                    |
| Field   | `profiler`         |            | profiler library name [`DDTrace`, `py-spy`, `Pyroscope`, ...]  |
| Field   | `library_ver`      |            | profiler library version                                      |
| Field   | `profiler_version` |            | profiler library version                                      |
| Field   | `profile_id`       |            | profiling unique ID                                           |
| Field   | `datakit_ver`      |            | Datakit version                                               |
| Field   | `start`            | nanosecond | profiling start timestamp                                     |
| Field   | `end`              | nanosecond | profiling end timestamp                                       |
| Field   | `duration`         | nanosecond | profiling duration                                            |
| Field   | `pid`              |            | process ID                                                    |
| Field   | `process_id`       |            | process ID                                                    |
| Field   | `format`           |            | profiling file format                                         |
| Field   | `__file_size`      | Byte       | total size of profiling file                                  |
