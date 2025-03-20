---
title     : 'Proxy'
summary   : 'Proxy Datakit’s HTTP requests'
tags:
  - 'PROXY'
__int_icon: 'icon/proxy'
dashboard :
  - desc  : 'Not available yet'
    path  : '-'
monitor   :
  - desc  : 'Not available yet'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Proxy Datakit’s requests, sending its data from the internal network to the public network.

<!-- TODO: A network traffic topology diagram for the proxy is missing here -->

## Configuration {#config}

### Collector Configuration {#input-config}

Select a DataKit in the network that can access the external network and configure its proxy settings as the proxy.

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/proxy` directory under the DataKit installation directory, copy `proxy.conf.sample`, and rename it to `proxy.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.proxy]]
      ## choose some inner IP address
      bind = "127.0.0.1"
      ## default bind port
      port = 9530
    
      # allowed client IP address (in CIDR format)
      allowed_client_cidrs = []
    
      # verbose mode will show more info during proxying.
      verbose = false
    
      # mitm: man-in-the-middle mode
      mitm = false
    
    ```

    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    Currently, you can enable the collector via [ConfigMap injection of the collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).

---

???+ attention "Security-related configurations"

    In some cases, the proxy may need to be exposed on the public network. At this point, we need to take necessary security measures to prevent attackers from exploiting the proxy.

    1. Enable client whitelist control (`allowed_client_cidrs`): Only proxy requests from specified clients, for example:

    ```toml
    # IPv6 CIDR configuration supported here
    allowed_client_cidrs = ["10.0.0.0/8", "2001:db8::/32"]
    ```

    1. If deployed on a public cloud, set up internal network CIDR access on the VPC. You can also add iptables rules on the corresponding host:

    ```shell
    # Example of an operating system-level firewall (using Linux iptables)
    iptables -A INPUT -p tcp --dport 9530 -s 10.0.0.0/8 -j ACCEPT  # Allow only internal network access
    iptables -A INPUT -p tcp --dport 9530 -j DROP
    ```

<!-- markdownlint-enable -->

## Network Topology {#network-topo}

If an internal Datakit points its Proxy to another Datakit with the Proxy collector enabled:

```toml
[dataway]
  http_proxy = "http://some-datakit-with-proxy-ip:port"
```

Then the request traffic from various internal Datakits will be routed through the Proxy (assuming the Proxy binds to port 9530):

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
dk_X_proxy --> |https://openway.guance.com|dw;
end
```

### About MITM Mode {#mitm}

Enabling MITM mode is mainly for collecting more detailed metrics about the Proxy. The principle is:

- When an internal Datakit connects to the Proxy, it must trust the HTTPS certificate provided by the Proxy collector (this certificate is definitely insecure; its source is [here](https://github.com/elazarl/goproxy/blob/master/certs.go){:target="_blank"}).
- Once the Datakit trusts this HTTPS certificate, the Proxy collector can sniff the content of HTTPS packets and thus record more request-related metrics.
- After recording the metric information, the Proxy collector forwards the request to Dataway (using Guance’s secure HTTPS certificate).

Here, although an insecure certificate is used between Datakit and Proxy, it is limited to internal network traffic. When the Proxy forwards traffic to the public Dataway, it still uses a secure HTTPS certificate.

<!-- markdownlint-disable MD046 -->
???+ attention

    Enabling MITM mode significantly reduces the performance of the Proxy. See the performance test results below.
<!-- markdownlint-enable -->

## Metrics {#metric}

Refer to the [Datakit self-metrics](../datakit/datakit-metrics.md), search for `proxy` to get related metrics.

<!-- markdownlint-disable MD046 -->
???+ attention

    If MITM functionality is not enabled, there will be no `datakit_input_proxy_api_total` and `datakit_input_proxy_api_latency_seconds` metrics.
<!-- markdownlint-enable -->

## Performance Testing {#benchmark}

Through writing simple HTTP server/client programs, basic environment parameters are as follows:


- Hardware: Apple M1 Pro/16GB
- OS: macOS Ventura 13
- Server: A plain HTTPS service that receives POST requests to `/v1/write/` and directly returns 200
- Client: POSTs a text file of approximately 170KB (*metric.data*) to the server
- Proxy: A locally running Datakit Proxy collector (`http://localhost:19530`)
- Request volume: A total of 16 clients, each sending 100 requests

The command is as follows:

```shell
$ ./cli -c 16 -r 100 -f metric.data -proxy http://localhost:19530

...
```

The following performance test results were obtained:

- Performance without enabling MITM:

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

- Performance after enabling MITM drops sharply (~100X):

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

- Without enabling MITM, TPS is approximately 1600/0.249329709 = 6417/s
- After enabling MITM, TPS drops to 1600/29.454341333 = 54/s

Therefore, **it is not recommended** to enable MITM functionality in production environments; it should only be used for debugging or testing.