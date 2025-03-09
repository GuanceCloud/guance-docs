# Datakit Occupied Ports

During the operation of Datakit, different local ports need to be opened based on various functionalities. The current port usage is as follows:

| Default Port(s) (possibly multiple) | Protocol (L4/L7) | Function Name                        | Default Route or Domain Socket (possibly multiple)                |
| ---                                 | ---              | ---                                  | --------------------------------------------------------------- |
| 2055                                | UDP              | NetFlow netflow9 default port        | N/A                                                             |
| 2056                                | UDP              | NetFlow netflow5 default port        | N/A                                                             |
| 2280                                | TCP              | Cat Trace data ingestion             | N/A                                                             |
| 4040                                | HTTP             | Pyroscope Profile data ingestion     | `/ingest`                                                       |
| 4317                                | gRPC             | OpenTelemetry data ingestion         | `otel/v1/traces`, `otel/v1/metrics`                             |
| 4739                                | UDP              | NetFlow ipfix default port           | N/A                                                             |
| 5044                                | TCP              | Beats data ingestion                 | N/A                                                             |
| 6343                                | UDP              | NetFlow sflow5 default port          | N/A                                                             |
| 8125                                | UDP              | StatsD data ingestion                | N/A                                                             |
| 9109                                | UDP/TCP          | Graphite data ingestion              | N/A                                                             |
| 9529                                | HTTP             | Datakit HTTP service                 |                                                                  |
| 9530                                | TCP              | Socket (TCP) log ingestion            | N/A                                                             |
| 9531                                | TCP              | DCA Server                           | N/A                                                             |
| 9531                                | UDP              | Socket (UDP) log ingestion            | N/A                                                             |
| 9533                                | WebSocket        | SideCar logfwdserver data ingestion  | N/A                                                             |
| 9542                                | HTTP             | Remote upgrade                       | `/v1/datakit/version`, `/v1/datakit/upgrade`                     |