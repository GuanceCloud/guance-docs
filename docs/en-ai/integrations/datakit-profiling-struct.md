---
skip: 'not-searchable-on-index-page'
title: 'Datakit Profiling Related Data Structures'
---

This document introduces the definitions of profiling-related data structures in Datakit.

## Introduction to Datakit Line Protocol {#line-protocol}

- Line Protocol is the final data format that gets written to disk.
- The Line Protocol data structure is a string composed of four parts: Name, Tags, Fields, and Timestamp, along with delimiters (English comma, space), formatted as:

```line protocol
source_name,key1=value1,key2=value2 field1=value1,field2=value2 ts
```

## Tags and Fields Used in Datakit Profiling Line Protocol {#tags-fields}

| Section | Name               | Unit       | Description                                                   |
|---------|--------------------|------------|---------------------------------------------------------------|
| Tag     | `host`             |            | Host name                                                     |
| Tag     | `endpoint`         |            | Endpoint of resource                                          |
| Tag     | `service`          |            | Service name                                                  |
| Tag     | `env`              |            | Environment arguments                                         |
| Tag     | `version`          |            | Service version                                               |
| Tag     | `language`         |            | Language [`Java`, `Python`, `Golang`, ...]                    |
| Field   | `runtime`          |            | Runtime [`jvm`, `CPython`, `go`, ....]                        |
| Field   | `runtime_os`       |            | Operating system                                              |
| Field   | `runtime_arch`     |            | CPU architecture                                              |
| Field   | `runtime_version`  |            | Programming language version                                  |
| Field   | `runtime_compiler` |            | Compiler                                                      |
| Field   | `runtime_id`       |            | Unique ID allocated once process bootstrap                    |
| Field   | `profiler`         |            | Profiler library name [`DDTrace`, `py-spy`, `Pyroscope`, ...] |
| Field   | `library_ver`      |            | Profiler library version                                      |
| Field   | `profiler_version` |            | Profiler library version                                      |
| Field   | `profile_id`       |            | Unique ID for profiling                                       |
| Field   | `datakit_ver`      |            | Datakit version                                               |
| Field   | `start`            | Nanosecond | Profiling start timestamp                                     |
| Field   | `end`              | Nanosecond | Profiling end timestamp                                       |
| Field   | `duration`         | Nanosecond | Profiling duration                                            |
| Field   | `pid`              |            | Process ID                                                    |
| Field   | `process_id`       |            | Process ID                                                    |
| Field   | `format`           |            | Profiling file format                                         |
| Field   | `__file_size`      | Byte       | Total size of profiling file                                  |