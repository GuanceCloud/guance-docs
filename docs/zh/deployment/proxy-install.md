# 代理部署  {#agency-install}

## 简介

由于本地部署 Kubernetes 集群无法使用 `LoadBalancer` 服务，所以我们可以使用 `Nginx` 或 `Haproxy` 进行代理

## 前提条件

- 已部署 Kubernetes 集群，未部署可参考 [Kubernetes 部署](http://127.0.0.1:8000/deployment/infra-kubernetes/)
- 已部署 Ingress-nginx 服务，未部署可参考 [Ingress-nginx](ingress-nginx-install.md)

## 基础信息及兼容

|     名称     |                   描述                   |
| :------------------: | :---------------------------------------------: |
|     配置二级域名     |                   dataflux.cn                   |
|      集群节点IP      | 192.168.100.101,192.168.100.102,192.168.100.103 |
| Ingress-nginx 端口号 |                      32280                      |
|    是否支离线安装    |                       否                        |
|       支持架构       |                   amd64/arm64                   |
|      部署机器IP      |                 192.168.100.104                 |



## 安装步骤

### 1、查询端口

获取 ingress-nginx NodePort 端口号

```shell
kubectl get svc -n ingress-nginx
```
![ingress-nginx-svc.png](img/21.deployment_1.png)

### 2、安装并配置

=== "Nginx"

    - 安装
    
      在单独机器上部署
    
      ```shell
      ## 安装
      yum install -y nginx
      ## 启动
      nginx 
      ```
    
    - 配置
    
    ???+ warning "注意"
         请务必修改配置中的 IP 和端口号以及你的域名，此配置域名为 `dataflux.cn`
    
    修改以下配置，并保存到 `/etc/nginx/conf.d` 目录下，名称为 **`dataflux.conf`**
    
    ???- note "dataflux.conf(单击点开)"
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
    
    - 生效配置
      ```shell
      nginx -s reload
      ```

=== "Haproxy"

    - 安装
    
      在 [`192.168.100.104`](#install-info) 机器上部署
      ```shell
      ## 安装
      yum install -y haproxy
      ```
    
    - 配置
    
    ???+ warning "注意"
         请务必修改配置中的 IP 和端口号以及你的域名，此配置域名为 `dataflux.cn`
    
      修改以下配置，并保存到 `/etc/haproxy/` 目录下，名称为 **`haproxy.cfg`**      
    ???- note "haproxy.cfg(单击点开)"
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
    
         # 443 https 端口配置 可以不配 配就放开注释
         #frontend https_frontend
         #        bind *:443 ssl crt /etc/ssl/certs/dataflux.cn.pem # ssl证书
         #        mode http
         #        option httpclose
         #        option forwardfor
         #        reqadd X-Forwarded-Proto:\ https
         #        #default_backend web_server
         #        # 不走ingress
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
         #       # 不走ingress
         #        use_backend vip_2_servers if kodo
    
         # dynamic-static separation
         frontend http_web
                 mode http
                 bind *:80
         #        redirect scheme https if !{ ssl_fc}
                 option httpclose
                 option forwardfor
                 ###### 请修改你的域名 dataflux.cn 改为你域名
                 acl kodo           hdr(Host)  -i df-kodo.dataflux.cn
                 acl test           hdr(Host)  -i test.dataflux.cn
                 acl launcher       hdr(Host)  -i launcher.dataflux.cn
                 acl dataflux       hdr(Host)  -i dataflux.dataflux.cn
                 acl func           hdr(Host)  -i df-func.dataflux.cn
                 acl api            hdr(Host)  -i df-api.dataflux.cn
                 acl management     hdr(Host)  -i df-management.dataflux.cn
                 acl management-api hdr(Host)  -i df-management-api.dataflux.cn
                 acl static         hdr(Host)  -i df-static-res.dataflux.cn
    
                 acl dataway         hdr(Host)  -i df-dataway.dataflux.cn
                 use_backend vip_1_servers if dataflux
                 use_backend vip_1_servers if func
                 use_backend vip_1_servers if launcher
                 use_backend vip_1_servers if static
                 use_backend vip_1_servers if api
                 use_backend vip_1_servers if management
                 use_backend vip_1_servers if management-api
                 use_backend vip_1_servers if kodo
                 use_backend vip_1_servers if test
         # ingress 端口 ip是k8s的集群的 请替换ip
         backend vip_1_servers
                 balance roundrobin
                 server ingress_1 192.168.100.101:32280 check inter 1500 rise 3 fall 3
                 server ingress_2 192.168.100.102:32280 check inter 1500 rise 3 fall 3
                 server ingress_3 192.168.100.103:32280 check inter 1500 rise 3 fall 3
         ```
    
    - 启动
      ```shell
      systemctl start haproxy
      ```

### 3、测试

#### 3.1 创建测试服务

```shell
# 创建测试 deployment
kubectl create deployment ingress-test --image=nginx --port=80
# 创建测试 svc
kubectl expose deployment ingress-test --port=80 --target-port=80
# 创建测试 ingress
kubectl create ingress ingress-test --rule='test.dataflux.cn/=ingress-test:80'
```

#### 3.2 测试

???+ warning "注意"

     `192.168.100.104` 为代理服务器 IP。

```shell
 curl -H 'Host:test.dataflux.cn' 192.168.100.104
```

成功结果：
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

#### 3.3 清理测试服务
```shell
kubectl delete deployment ingress-test
kubectl delete svc ingress-test
kubectl delete ingress ingress-test
```

## 卸载

=== "Nginx"
    
    ```shell
    rpm -e --nodeps nginx 
    ```


=== "Haproxy"

    ```shell
    rpm -e --nodeps haproxy 
    ```
