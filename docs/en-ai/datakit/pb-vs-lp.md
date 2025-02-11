# Switching from Line Protocol to Protobuf

---

## Line Protocol {#lp}

Due to historical reasons, Datakit internally uses InfluxDB's line protocol as the basic data structure to represent a specific data point. Its basic form is as follows:

```txt
<measurement>,<tag-list> <field-list> timestamp
```

The line protocol refers to representing a specific data point with a single line of text like this. For example, the following data point represents a basic disk usage situation:

```txt
disk,device=/dev/disk3s1s1,fstype=apfs free=167050518528i,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064064000
```

Here, `disk` is the metrics set, `device` and `fstype` are two tags, followed by a series of specific metrics for this data point. The last large integer represents a Unix timestamp in nanoseconds.

Several values ending with `i` indicate signed integers. This data point represents specific disk usage. Besides `i`, it also supports:

- Floating-point (like `used_percent`, which does not have a type suffix)
- Unsigned integers (suffix `u`)
- Strings
- Booleans

If there are multiple data points, they are represented on separate lines (hence the name "line protocol"):

```text
disk,device=/dev/disk3s1s1,fstype=apfs free=167050518528i,,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064064000
disk,device=/dev/disk3s6,fstype=apfs free=167050518528i,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064243000
disk,device=/dev/disk3s2,fstype=apfs free=167050518528i,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064254000
disk,device=/dev/disk3s4,fstype=apfs free=167050518528i,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064260000
```

The line protocol, due to its readability and basic data representation capabilities, met our needs during the initial phase of use.

## Protobuf {#pb}

As data collection deepened, we faced two main issues:

- The line protocol can only represent relatively simple data types, such as not supporting array-type fields.

In process collection, we need to collect lists of open ports, which can only be represented through JSON embedded in strings. Binary data support is virtually non-existent.

- The official InfluxDB line protocol SDK has design flaws and performance issues:

    - Once a data point (Point) is constructed, performing secondary operations (such as Pipeline) requires re-parsing the Point, leading to CPU/memory waste.
    - Poor encoding/decoding performance affects data processing under high throughput conditions.

---

Based on these reasons, we abandoned the line protocol (v1) and adopted a completely custom data structure (v2), using Protobuf for transmission. Compared to v1, v2 offers several enhancements:

- Fully customizable data types, breaking away from InfluxDB's constraints on Points. We added support for arrays, maps, and binary data.

    - With binary support, we can directly add binary files to Points, such as appending Profile files to profile data points.
    - Protobuf's [JSON structure](apis.md#api-v1-write-body-pbjson-protocol) can be used directly in HTTP requests, whereas the line protocol lacks a corresponding JSON format, forcing developers to familiarize themselves with the line protocol.

- Constructed data points remain modifiable without encapsulation.
- In terms of encoded size, while gzipped line protocol data is slightly smaller (difference within 0.1% for a 1MB payload), Protobuf is not far behind.
- Protobuf has higher encoding/decoding efficiency. Benchmarks show that encoding efficiency is approximately X10, and decoding efficiency is around X5:

```shell
# Encoding
BenchmarkEncode/bench-encode-lp
BenchmarkEncode/bench-encode-lp-10 250 4777819 ns/op 8674069 B/op 41042 allocs/op
BenchmarkEncode/bench-encode-pb
BenchmarkEncode/bench-encode-pb-10 2710 433151 ns/op 1115021 B/op 16   allocs/op
# Decoding
BenchmarkDecode/decode-lp
BenchmarkDecode/decode-lp-10 72 15973900 ns/op 4670584 B/op 90286 allocs/op
BenchmarkDecode/decode-pb
BenchmarkDecode/decode-pb-10 393 3044680 ns/op 3052845 B/op 70025 allocs/op
```

Based on the improvements in v2 across various aspects, we conducted some basic tests on observability. There were noticeable improvements in memory and CPU usage:

On medium to low load Datakits, the performance difference between v2 and v1 is significant:

<figure markdown>
  ![not-set](https://static.guance.com/images/datakit/lp-vs-pb/v1-v2-mid-pressure.png)
</figure>

At 10:30 AM when switching from v2 to v1, both CPU and memory usage increased significantly. On high-load Datakits, the performance difference is also evident:

<figure markdown>
  ![not-set](https://static.guance.com/images/datakit/lp-vs-pb/v1-v2-high-pressure.png)
</figure>

At 11:45 PM when switching to v2, sys/heap mem was much lower compared to the next day at 10:30 AM when switching to v1. Regarding CPU, after switching to v1 at 10:30 AM, there was an increase but not very significant, mainly because the primary CPU usage on high-load Datakits is not related to data encoding.

## Conclusion {#conclude}

Compared to v1, v2 not only shows significant performance improvements but also offers greater flexibility. Additionally, v2 supports encoding in v1 format to maintain compatibility with older deployment versions and development habits. In Datakit, combining [point-pool](datakit-conf.md#point-pool) can achieve better memory/CPU performance.