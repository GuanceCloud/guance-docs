# Switching from Line Protocol to Protobuf

---

## Line Protocol {#lp}

Due to historical reasons, Datakit internally uses InfluxDB's line protocol as the basic data structure to represent a specific data point. Its basic form is as follows:

```txt
<measurement>,<tag-list> <field-list> timestamp
```

The line protocol refers to representing a specific data point with one line of text like this. For example, the following data point represents a basic disk usage situation:

```txt
disk,device=/dev/disk3s1s1,fstype=apfs free=167050518528i,total=494384795648i,used=327334277120i,used_percent=66.21042556354438 1685509141064064000
```

Here, `disk` is the measurement set, `device` and `fstype` are two tags, followed by a series of specific metrics for this point. The last large integer represents a Unix timestamp in nanoseconds.

Values ending with `i` indicate signed integers. This data point represents specific disk usage details. Besides `i`, it also supports:

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

The line protocol, due to its readability and basic data expression capabilities, initially met our needs.

## Protobuf {#pb}

As data collection deepened, we faced two issues:

- The data types supported by the line protocol were somewhat limited. For instance, it did not support array-type fields.

During process collection, we needed to gather lists of open ports for processes, which could only be represented through JSON embedded in strings. Binary data was almost unsupported.

- The official InfluxDB line protocol SDK was poorly designed and had some performance issues:

    - After constructing a data point (Point), any secondary operations (such as Pipeline) required re-parsing the Point, leading to CPU and memory waste.
    - Poor encoding/decoding performance affected data processing under high throughput.

---

Based on these reasons, we abandoned the line protocol data structure (v1) and adopted a completely custom data structure (v2), using Protobuf for transmission. Compared to version v1, v2 supports more features:

- Fully customizable data types, free from InfluxDB's constraints on Points. We added support for array/map/binary types.

    - With binary support, we can directly add binary files to Points, such as appending Profile files to profile data points.
    - Protobuf's [JSON structure](apis.md#api-v1-write-body-pbjson-protocol) can be used directly in HTTP requests, whereas the line protocol lacks a corresponding JSON format, forcing developers to familiarize themselves with the line protocol.

- Constructed data points can still be freely modified without encapsulation.
- In terms of encoded size, since the line protocol is entirely text-based, gzip compression results in slightly smaller sizes (within 0.1% difference for a 1MB payload). Protobuf performs well in this aspect too.
- Protobuf has higher encoding/decoding efficiency. Benchmarks show that encoding efficiency is approximately X10, and decoding efficiency is about X5:

```shell
# Encoding
BenchmarkEncode/bench-encode-lp
BenchmarkEncode/bench-encode-lp-10 250 4777819 ns/op 8674069 B/op 41042 allocs/op
BenchmarkEncode/bench-encode-pb
BenchmarkEncode/bench-encode-pb-10 2710 433151 ns/op 1115021 B/op 16 allocs/op
# Decoding
BenchmarkDecode/decode-lp
BenchmarkDecode/decode-lp-10 72 15973900 ns/op 4670584 B/op 90286 allocs/op
BenchmarkDecode/decode-pb
BenchmarkDecode/decode-pb-10 393 3044680 ns/op 3052845 B/op 70025 allocs/op
```

Based on the improvements in v2 across various aspects, we conducted basic tests on observability, and both memory and CPU usage showed significant improvements:

On medium to low load Datakits, the performance difference between v2 and v1 is very noticeable:

<figure markdown>
  ![not-set](https://static.guance.com/images/datakit/lp-vs-pb/v1-v2-mid-pressure.png)
</figure>

At 10:30 AM, switching from v2 to v1 resulted in noticeable increases in CPU and memory usage. On high-load Datakits, the performance difference is also evident:

<figure markdown>
  ![not-set](https://static.guance.com/images/datakit/lp-vs-pb/v1-v2-high-pressure.png)
</figure>

At 23:45, switching to v2 resulted in significantly lower sys/heap memory compared to switching to v1 at 10:30 AM the next day. In terms of CPU, switching to v1 at 10:30 AM caused an increase, but it was not very significant because the main CPU usage in high-load Datakits is not related to data encoding.

## Conclusion {#conclude}

Compared to v1, v2 offers significant performance improvements and greater extensibility. Additionally, v2 supports encoding in v1 format to maintain compatibility with older deployment versions and development habits. In Datakit, we can combine the use of [point-pool](datakit-conf.md#point-pool) to achieve better memory/CPU performance.