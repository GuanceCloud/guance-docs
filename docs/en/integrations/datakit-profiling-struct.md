---
skip: 'not-searchable-on-index-page'
title: 'Datakit Profiling Related Data Structures'
---

This article introduces the definition of profiling related data structures in Datakit.

## Introduction to Datakit Line Protocol {#line-protocol}

- Line Protocol is the final data that lands on the disk in the data stream.
- The Line Protocol data structure is a string composed of four parts: Name, Tags, Fields, Timestamp, and delimiters (English comma, space), such as:

```line protocol
source_name,key1=value1,key2=value2 field1=value1,field2=value2 ts
```

## Tags and Fields Used in the Datakit Profiling Line Protocol {#tags-fields}

| Section | Name               | Unit       | Description                                                   |
|---------|--------------------|------------|---------------------------------------------------------------|
| Tag     | `host`             |            | host name                                                     |
| Tag     | `endpoint`         |            | end point of resource                                         |
| Tag     | `service`          |            | service name                                                  |
| Tag     | `env`              |            | environment arguments                                         |
| Tag     | `version`          |            | service version                                               |
| Tag     | `languages`        |            | languages [`Java`, `Python`, `Golang`, ...]                   |
| Field   | `runtimes`         |            | runtimes [`jvm`, `CPython`, `go`, ....]                      |
| Field   | `runtime_os`       |            | operating systems                                             |
| Field   | `runtime_arch`     |            | cpu architectures                                              |
| Field   | `runtime_versions` |            | programming language versions                                  |
| Field   | `runtime_compilers`|            | compilers                                                     |
| Field   | `runtime_ids`      |            | unique IDs allocated once process bootstrap                   |
| Field   | `profilers`        |            | profiler library names [`DDTrace`, `py-spy`, `Pyroscope`, ...] |
| Field   | `library_ver`      |            | profiler library versions                                     |
| Field   | `profiler_versions`|            | profiler library versions                                     |
| Field   | `profile_ids`      |            | unique IDs for profiling                                      |
| Field   | `datakit_ver`      |            | Datakit versions                                              |
| Field   | `start`            | nanosecond | profiling start timestamps                                    |
| Field   | `end`              | nanosecond | profiling end timestamps                                      |
| Field   | `duration`         | nanosecond | profiling durations                                           |
| Field   | `pids`             |            | process ids                                                  |
| Field   | `process_ids`      |            | process ids                                                  |
| Field   | `formats`          |            | profiling file formats                                       |
| Field   | `__file_size`      | Byte       | total sizes of profiling files                               |