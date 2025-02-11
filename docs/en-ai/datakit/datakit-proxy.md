# DataKit Proxy

When DataKit cannot access the internet, you can deploy a proxy within the internal network to send traffic out. This document provides two implementation methods:

- Through the built-in proxy service of DataKit
- Through the Nginx proxy service

## Built-in DataKit Proxy {#datakit}

For configuring the built-in Proxy collector, refer to [this link](../integrations/proxy.md).

Enter the `conf.d/` directory under the **proxied** DataKit installation directory and configure the proxy service in `datakit.conf`. As follows:

```toml
[dataway]
  urls = ["https://openway.guance.com?token=<YOUR-TOKEN>"]
  http_proxy = "http://<PROXY-IP:PROXY-PORT>"
```

After configuration, [restart DataKit](datakit-service-how-to.md#manage-service).

### Testing the Proxy {#testing}

Test if the proxy service is working properly:

- By sending metrics to the workspace for testing

```shell
curl -x <PROXY-IP:PROXY-PORT> -v -X POST https://openway.guance.com/v1/write/metrics?token=<YOUR-TOKEN> -d "proxy_test,name=test c=123i"
```

If the proxy server is functioning correctly, the workspace will receive the metric data `proxy_test,name=test c=123i`.

## Nginx {#nginx}

To proxy HTTPS traffic, Nginx uses a Layer 4 transparent proxy method, which requires:

- An Nginx transparent proxy server that can access the internet
- The client machine where DataKit resides should use the *hosts* file for domain name configuration

### Configuring the `Nginx` Proxy Service {#config-nginx-proxy}

```nginx
# Proxy HTTPS
stream {
    # resolver 114.114.114.114;
    # resolver_timeout 30s;
    server {
        listen 443;
        ssl_preread on;
        proxy_connect_timeout 10s;
        proxy_pass $ssl_preread_server_name:$server_port;
    }
}

http {
    ...
}
```

For proxying HTTP traffic, Nginx uses a Layer 7 transparent proxy method (if you do not need to proxy HTTP, you can skip this section):

```nginx
# Proxy HTTP
http {
    # resolver 114.114.114.114;
    # resolver_timeout 30s;
    server {
        listen 80;
        location / {
            proxy_pass http://$http_host$request_uri;    # Configure forward proxy parameters
            proxy_set_header Host $http_host;            # Solve nginx 503 error when URL contains "."
            proxy_buffers 256 4k;                        # Configure buffer size
            proxy_max_temp_file_size 0;                  # Disable disk cache read/write to reduce I/O
            proxy_connect_timeout 30;                    # Proxy connection timeout
            proxy_cache_valid 200 302 10m;
            proxy_cache_valid 301 1h;
            proxy_cache_valid any 1m;                    # Configure proxy server cache time
            proxy_send_timeout 60;
            proxy_read_timeout 60;
        }
    }

    // ... other configurations
}
```

### Loading New Configuration and Testing {#load-test}

```shell
$ nginx -t        # Test configuration
...

$ nginx -s reload # Reload configuration
...
```

Configure the domain names on the proxied DataKit machine. Assume `192.168.1.66` is the IP address of the Nginx transparent proxy server.

```shell
$ sudo vi /etc/hosts

192.168.1.66 static.guance.com
192.168.1.66 openway.guance.com
192.168.1.66 dflux-dial.guance.com

192.168.1.66 static.dataflux.cn
192.168.1.66 openway.dataflux.cn
192.168.1.66 dflux-dial.dataflux.cn

192.168.1.66 zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com
```

On the proxied machine, test if the proxy is working properly:

<!-- markdownlint-disable MD046 -->
=== "Linux/Unix Shell"

    ```shell
    curl -H "application/x-www-form-urlencoded; param=value" \
      -d 'proxy_test_nginx,name=test c=123i' \
      "https://openway.guance.com/v1/write/metrics?token=<YOUR-TOKEN>"
    ```

=== "Windows PowerShell"

    ```PowerShell
    curl -uri 'https://openway.guance.com/v1/write/metrics?token=<YOUR-TOKEN>' -Headers @{"param"="value"} -ContentType 'application/x-www-form-urlencoded' -body 'proxy_test_nginx,name=test c=123i' -method 'POST'
    ```
    
    Note: On some machines, PowerShell may report an error `curl: The request was aborted: Could not create SSL/TLS secure channel.` This is because the server certificate encryption version is not supported by the local default settings. You can check the supported protocols using the command `[Net.ServicePointManager]::SecurityProtocol`. To enable support locally, perform the following operations:
    
    ```PowerShell
    # 64-bit PowerShell
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
    
    # 32-bit PowerShell
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
    ```
    
    Close the PowerShell window, open a new PowerShell window, and run the following code to check the supported protocols:
    
    ```PowerShell
    [Net.ServicePointManager]::SecurityProtocol
    ```
<!-- markdownlint-enable -->