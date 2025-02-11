---
title     : 'Proxy'
summary   : 'Proxy Datakit’s HTTP requests'
tags:
  - 'PROXY'
__int_icon: 'icon/proxy'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Proxy the requests from Datakit, forwarding its data from the internal network to the public network.

<!-- TODO: A network traffic topology diagram for the proxy is missing here -->

## Configuration {#config}

### Collector Configuration {#input-config}

Select a DataKit in the network that can access the internet and configure it as a proxy by setting up its proxy settings.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/proxy` directory under the DataKit installation directory, copy `proxy.conf.sample` and rename it to `proxy.conf`. Example configuration:
    
    ```toml
        
    [[inputs.proxy]]
      ## default bind ip address
      bind = "0.0.0.0"
      ## default bind port
      port = 9530
    
      # verbose mode will show more info during proxying.
      verbose = false
    
      # mitm: man-in-the-middle mode
      mitm = false
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector via [ConfigMap injection](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

## Network Topology {#network-topo}

If an internal Datakit points its Proxy to another Datakit with Proxy enabled:

```toml
[dataway]
  http_proxy = "http://some-datakit-with-proxy-ip:port"
```

The request traffic from various internal Datakits will be routed through the Proxy (assuming the Proxy binds to port 9530):

``` mermaid
flowchart LR;
dk_A(Datakit A);
dk_B(Datakit B);
dk_C(Datakit C);
dk_X_proxy("Datakit X's Proxy(0.0.0.0:9530)");
dw(Dataway/Openway);

subgraph "Internal Network"
dk_A --> dk_X_proxy;
dk_B --> dk_X_proxy;
dk_C --> dk_X_proxy;
end

subgraph "Public Network"
dk_X_proxy ==> |https://openway.guance.com|dw;
end
```

### About MITM Mode {#mitm}

Enabling MITM mode facilitates collecting more detailed metrics from the Proxy. The principle is as follows:

- When an internal Datakit connects to the Proxy, it must trust the HTTPS certificate provided by the Proxy collector (this certificate is inherently insecure; the source [is here](https://github.com/elazarl/goproxy/blob/master/certs.go){:target="_blank"}).
- Once the Datakit trusts this HTTPS certificate, the Proxy collector can inspect the contents of HTTPS packets and record more detailed request metrics.
- After recording the metrics, the Proxy forwards the request to Dataway using Guance's secure HTTPS certificate.

Although an insecure certificate is used between Datakit and Proxy within the internal network, the Proxy forwards traffic to the public Dataway using a secure HTTPS certificate.

<!-- markdownlint-disable MD046 -->
???+ attention

    Enabling MITM mode significantly degrades Proxy performance; see the performance test results below.
<!-- markdownlint-enable -->

## Metrics {#metric}

The Proxy collector exposes the following Prometheus metrics:


| POSITION                        | TYPE    | NAME                                      | LABELS              | HELP                            |
| ---                             | ---     | ---                                       | ---                 | ---                             |
| *internal/plugins/inputs/proxy* | COUNTER | `datakit_input_proxy_connect`             | `client_ip`         | Proxy connect(method CONNECT) |
| *internal/plugins/inputs/proxy* | COUNTER | `datakit_input_proxy_api_total`           | `api,method`        | Proxy API total               |
| *internal/plugins/inputs/proxy* | SUMMARY | `datakit_input_proxy_api_latency_seconds` | `api,method,status` | Proxy API latency             |

If these metrics are enabled in Datakit's own metric reporting, they will appear in the built-in views related to the Proxy collector.

<!-- markdownlint-disable MD046 -->
???+ attention

    If MITM is not enabled, the `datakit_input_proxy_api_total` and `datakit_input_proxy_api_latency_seconds` metrics will not be available.
<!-- markdownlint-enable -->

## Performance Testing {#benchmark}

Using simple HTTP server/client programs, the basic environment parameters are:

- Hardware: Apple M1 Pro/16GB
- OS: macOS Ventura 13
- Server: An empty-running HTTPS service that accepts POST requests to `/v1/write/` and returns 200 immediately.
- Client: POSTs a 170KB text file (*metric.data*) to the server.
- Proxy: A locally running Datakit Proxy collector (`http://localhost:19530`)
- Request volume: 16 clients, each sending 100 requests

Command:

```shell
$ ./cli -c 16 -r 100 -f metric.data -proxy http://localhost:19530

...
```

Performance test results:

- Without MITM enabled:

```not-set
Benchmark metrics:
# HELP api_elapsed_seconds Proxied API elapsed seconds
# TYPE api_elapsed_seconds gauge
api_elapsed_seconds 0.249329709
# HELP api_latency_seconds Proxied API latency
# TYPE api_latency_seconds summary
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.5"} 0.002227916
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.9"} 0.002964042
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.99"} 0.008195959
api_latency_seconds_sum{api="/v1/write/xxx",status="200 OK"} 3.9450724669999992
api_latency_seconds_count{api="/v1/write/xxx",status="200 OK"} 1600
# HELP api_post_bytes_total Proxied API post bytes total
# TYPE api_post_bytes_total counter
api_post_bytes_total{api="/v1/write/xxx",status="200 OK"} 2.764592e+08
```

- With MITM enabled, performance drops significantly (~100X):

``` not-set
Benchmark metrics:
# HELP api_elapsed_seconds Proxied API elapsed seconds
# TYPE api_elapsed_seconds gauge
api_elapsed_seconds 29.454341333
# HELP api_latency_seconds Proxied API latency
# TYPE api_latency_seconds summary
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.5"} 0.29453425
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.9"} 0.405621917
api_latency_seconds{api="/v1/write/xxx",status="200 OK",quantile="0.99"} 0.479301875
api_latency_seconds_sum{api="/v1/write/xxx",status="200 OK"} 461.3323555329998
api_latency_seconds_count{api="/v1/write/xxx",status="200 OK"} 1600
# HELP api_post_bytes_total Proxied API post bytes total
# TYPE api_post_bytes_total counter
api_post_bytes_total{api="/v1/write/xxx",status="200 OK"} 2.764592e+08
```

Conclusion:

- Without MITM enabled, TPS is approximately 1600/0.249329709 = 6417/s.
- With MITM enabled, TPS drops to 1600/29.454341333 = 54/s.

Therefore, **it is not recommended** to enable MITM in production environments; use it only for debugging or testing.