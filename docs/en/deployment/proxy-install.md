# Proxy Deployment  {#agency-install}

## Introduction

Since local Kubernetes clusters cannot use `LoadBalancer` services, we can use `Nginx` or `Haproxy` for proxying.

## Prerequisites

- A deployed Kubernetes cluster. If not deployed, refer to [Kubernetes Deployment](infra-kubernetes.md)
- Deployed Ingress-nginx service. If not deployed, refer to [Ingress-nginx Installation](ingress-nginx-install.md)

## Basic Information and Compatibility

| Name               | Description                                      |
| :------------------: | :---------------------------------------------: |
| Configure Subdomain | dataflux.cn                                      |
| Cluster Node IPs    | 192.168.100.101,192.168.100.102,192.168.100.103   |
| Ingress-nginx Port  | 32280                                            |
| Supports Offline Installation | No                                         |
| Supported Architectures | amd64/arm64                                    |
| Deployment Machine IP | 192.168.100.104                                 |

## Installation Steps

### 1. Query Ports

Obtain the ingress-nginx NodePort port number

```shell
kubectl get svc -n ingress-nginx
```
![ingress-nginx-svc.png](img/21.deployment_1.png)

### 2. Installation and Configuration

=== "Nginx"

    - Installation
    
      Deploy on a separate machine
    
      ```shell
      ## Install
      yum install -y nginx
      ## Start
      nginx 
      ```
    
    - Configuration
    
    ???+ warning "Note"
         Please make sure to modify the IP, port number, and domain name in the configuration. The domain name in this configuration is `dataflux.cn`
    
    Modify the following configuration and save it to the `/etc/nginx/conf.d` directory with the name **`dataflux.conf`**
    
    ???- note "dataflux.conf (Click to expand)"
         ```shell
         upstream httpbakend {
         server 192.168.100.101:32280;
         server 192.168.100.102:32280;
         server 192.168.100.103:32280;
         }
    
         server {
           listen 80;
           server_name *.dataflux.cn;
           location / {
             proxy_set_header Host $host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
             proxy_pass http://httpbakend;
            }
         }
    
         ```
    
    - Apply Configuration
      ```shell
      nginx -s reload
      ```

=== "Haproxy"

    - Installation
    
      Deploy on the [`192.168.100.104`](#install-info) machine
      ```shell
      ## Install
      yum install -y haproxy
      ```
    
    - Configuration
    
    ???+ warning "Note"
         Please make sure to modify the IP, port number, and domain name in the configuration. The domain name in this configuration is `dataflux.cn`
    
      Modify the following configuration and save it to the `/etc/haproxy/` directory with the name **`haproxy.cfg`**      
    ???- note "haproxy.cfg (Click to expand)"
         ```shell
         #---------------------------------------------------------------------
         # Example configuration for a possible web application.  See the
         # full configuration options online.
         #
         #   http://haproxy.1wt.eu/download/1.4/doc/configuration.txt
         #
         #---------------------------------------------------------------------
    
         #---------------------------------------------------------------------
         # Global settings
         #---------------------------------------------------------------------
         global
             # to have these messages end up in /var/log/haproxy.log you will
             # need to:
             #
             # 1) configure syslog to accept network log events.  This is done
             #    by adding the '-r' option to the SYSLOGD_OPTIONS in
             #    /etc/sysconfig/syslog
             #
             # 2) configure local2 events to go to the /var/log/haproxy.log
             #   file. A line like the following can be added to
             #   /etc/sysconfig/syslog
             #
             #    local2.*                       /var/log/haproxy.log
             #
             log         127.0.0.1 local2
    
             chroot      /var/lib/haproxy
             pidfile     /var/run/haproxy.pid
             maxconn     4000
             user        haproxy
             group       haproxy
             daemon
    
             # turn on stats unix socket
             stats socket /var/lib/haproxy/stats
    
         #---------------------------------------------------------------------
         # common defaults that all the 'listen' and 'backend' sections will
         # use if not designated in their block
         #---------------------------------------------------------------------
         defaults
             mode                    http
             log                     global
             option                  httplog
             option                  dontlognull
             option http-server-close
             option forwardfor       except 127.0.0.0/8
             option                  redispatch
             retries                 3
             timeout http-request    10s
             timeout queue           1m
             timeout connect         10s
             timeout client          1m
             timeout server          1m
             timeout http-keep-alive 10s
             timeout check           10s
             maxconn                 3000
    
         # 443 https port configuration can be omitted if not required
         #frontend https_frontend
         #        bind *:443 ssl crt /etc/ssl/certs/dataflux.cn.pem # SSL certificate
         #        mode http
         #        option httpclose
         #        option forwardfor
         #        reqadd X-Forwarded-Proto:\ https
         #        #default_backend web_server
         #        # bypass ingress
         #        acl kodo           hdr(Host)  -i df-kodo.dataflux.cn
         #
         #        acl launcher       hdr(Host)  -i launcher.dataflux.cn
         #        acl dataflux       hdr(Host)  -i dataflux.dataflux.cn
         #        acl func           hdr(Host)  -i df-func.dataflux.cn
         #        acl api            hdr(Host)  -i df-api.dataflux.cn
         #        acl management     hdr(Host)  -i df-management.dataflux.cn
         #        acl management-api hdr(Host)  -i df-management-api.dataflux.cn
         #        acl static         hdr(Host)  -i df-static-res.dataflux.cn
         #
         #        use_backend vip_1_servers if dataflux
         #        use_backend vip_1_servers if func
         #        use_backend vip_1_servers if launcher
         #        use_backend vip_1_servers if static
         #        use_backend vip_1_servers if api
         #        use_backend vip_1_servers if management
         #        use_backend vip_1_servers if management-api
         #
         #       # bypass ingress
         #        use_backend vip_2_servers if kodo
    
         # dynamic-static separation
         frontend http_web
                 mode http
                 bind *:80
         #        redirect scheme https if !{ ssl_fc}
                 option httpclose
                 option forwardfor
                 ###### Please modify your domain dataflux.cn to your domain
                 acl kodo           hdr(Host)  -i df-kodo.dataflux.cn
                 acl test           hdr(Host)  -i test.dataflux.cn
                 acl launcher       hdr(Host)  -i launcher.dataflux.cn
                 acl dataflux       hdr(Host)  -i dataflux.dataflux.cn
                 acl func           hdr(Host)  -i df-func.dataflux.cn
                 acl api            hdr(Host)  -i df-api.dataflux.cn
                 acl management     hdr(Host)  -i df-management.dataflux.cn
                 acl management-api hdr(Host)  -i df-management-api.dataflux.cn
                 acl static         hdr(Host)  -i df-static-res.dataflux.cn
                 acl docs            hdr(Host)  -i df-docs.dataflux.cn
    
                 acl dataway         hdr(Host)  -i df-dataway.dataflux.cn
                 use_backend vip_1_servers if dataflux
                 use_backend vip_1_servers if func
                 use_backend vip_1_servers if launcher
                 use_backend vip_1_servers if static
                 use_backend vip_1_servers if api
                 use_backend vip_1_servers if management
                 use_backend vip_1_servers if management-api
                 use_backend vip_1_servers if kodo
                 use_backend vip_1_servers if docs
                 use_backend vip_1_servers if test
         # ingress port IP is the K8S cluster's IP, please replace the IP
         backend vip_1_servers
                 balance roundrobin
                 server ingress_1 192.168.100.101:32280 check inter 1500 rise 3 fall 3
                 server ingress_2 192.168.100.102:32280 check inter 1500 rise 3 fall 3
                 server ingress_3 192.168.100.103:32280 check inter 1500 rise 3 fall 3
         ```
    
    - Start
      ```shell
      systemctl start haproxy
      ```

### 3. Testing

#### 3.1 Create Test Service

```shell
# Create test deployment
kubectl create deployment ingress-test --image=nginx --port=80
# Create test svc
kubectl expose deployment ingress-test --port=80 --target-port=80
# Create test ingress
kubectl create ingress ingress-test --rule='test.dataflux.cn/=ingress-test:80'
```

#### 3.2 Test

???+ warning "Note"

     `192.168.100.104` is the proxy server IP.

```shell
 curl -H 'Host:test.dataflux.cn' 192.168.100.104
```

Successful result:
```shell
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

#### 3.3 Cleanup Test Service
```shell
kubectl delete deployment ingress-test
kubectl delete svc ingress-test
kubectl delete ingress ingress-test
```

## Uninstallation

=== "Nginx"
    
    ```shell
    rpm -e --nodeps nginx 
    ```


=== "Haproxy"

    ```shell
    rpm -e --nodeps haproxy 
    ```