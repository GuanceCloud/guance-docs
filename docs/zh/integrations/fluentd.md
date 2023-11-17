---
title     : 'Fluentd'
summary   : '采集 Fluentd 的日志'
__int_icon: 'icon/fluentd'
---

<!-- markdownlint-disable MD025 -->
# Fluentd 日志
<!-- markdownlint-enable -->

Fluentd 日志采集，接受日志文本数据上报至观测云。

## 安装部署 {#config}

### 前置条件

- td-agent-4.2.x >= 4.2.x
- 检查 Fluentd 数据是否正常采集

### 采集器配置

进入 DataKit 安装目录下的 `conf.d/log` 目录，复制 `logstreaming.conf.sample` 并命名为 `logstreaming.conf`。示例如下：

```yaml

[inputs.logstreaming]
  ignore_url_tags = true
```

重启 DataKit

```yaml
systemctl restart datakit
```

#### Linux Fluentd 采集 nginx 日志接入 DataKit

以 Fluentd 采集 nginx 日志并转发至上级 server 端的 plugin 配置为例，我们不想直接发送到 server 端进行处理，想直接处理好并发送给 DataKit 上报至观测云平台进行分析。

```yaml
##pc端日志收集
<source>
  @type tail
  format ltsv
  path /var/log/nginx/access.log
  pos_file /var/log/buffer/posfile/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>
 
##收集的数据由tcp协议转发到多个server的49875端口
## Multiple output
<match nginx>
 type forward
  <server>
   name es01
   host es01
   port 49875
   weight 60
  </server>
  <server>
   name es02
   host es02
   port 49875
   weight 60
  </server>
</match>
```

对 match 的 output 做修改将类型指定成 http 类型并且将 endpoint 指向开启了 **logstreaming** 的 DataKit 地址即可完成采集

```yaml
##pc端日志收集
<source>
  @type tail
  format ltsv
  path /var/log/nginx/access.log
  pos_file /var/log/buffer/posfile/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>
 
##收集的数据由http协议转发至本地 DataKit
## nginx output
<match nginx>
  @type http
  endpoint http://127.0.0.1:9529/v1/write/logstreaming?source=nginx_td&pipeline=nginx.p
  open_timeout 2
  <format>
    @type json
  </format>
</match>
```

修改配置之后重启 td-agent ，完成数据上报

![image](imgs/input-fluentd-1.png)

可以通过 DQL 验证上报的数据：

```shell
dql > L::nginx_td LIMIT 1
-----------------[ r1.nginx_td.s1 ]-----------------
    __docid 'L_c6et7vk5jjqulpr6osa0'
create_time 1637733374609
    date_ns 96184
       host 'df-solution-ecs-018'
    message '{"120.253.192.179 - - [24/Nov/2021":"13:55:10 +0800] \"GET / HTTP/1.1\" 304 0 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\" \"-\""}'
     source 'nginx_td'
       time 2023-11-07 13:56:06 +0800 CST
---------
1 rows, 1 series, cost 2ms
```

#### windows Fluentd 采集 nginx 日志接入 DataKit

以 Fluentd 采集 nginx 日志并转发至上级 server 端的 plugin 配置为例，我们不想直接发送到 server 端进行处理，想直接处理好并发送给 DataKit 上报至观测云平台进行分析。

```bash
##pc端日志收集
<source>
  @type tail
  format ltsv
  path D://opt/nginx/log/access.log
  pos_file D://opt/nginx/log/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>
 
##收集的数据由tcp协议转发到多个server的49875端口
## Multiple output
<match nginx>
 type forward
  <server>
   name es01
   host es01
   port 49875
   weight 60
  </server>
  <server>
   name es02
   host es02
   port 49875
   weight 60
  </server>
</match>
```

对 match 的 output 做修改将类型指定成 http 类型并且将 endpoint 指向开启了 **logstreaming** 的 DataKit 地址即可完成采集

```yaml
## pc端日志收集
<source>
  @type tail
  format ltsv
  path D://opt/nginx/log/access.log
  pos_file D://opt/nginx/log/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>
 
## 收集的数据由http协议转发至本地 DataKit
## nginx output
<match nginx>
  @type http
  endpoint http://127.0.0.1:9529/v1/write/logstreaming?source=nginx_td&pipeline=nginx.p
  open_timeout 2
  <format>
    @type json
  </format>
</match>
```

修改配置之后重启`fluentd -c`更改的配置文件 ，完成数据上报

![image](imgs/input-fluentd-2.png)

可以通过 DQL 验证上报的数据：

```shell
dql > L::nginx_td LIMIT 1
-----------------[ r1.nginx_td.s1 ]-----------------
    __docid 'L_c6et7vk5jjqulpr6osa0'
create_time 1637733374609
    date_ns 96184
       host 'df-solution-ecs-018'
    message '{"120.253.192.179 - - [03/Mar/2022":"13:55:10 +0800] \"GET / HTTP/1.1\" 304 0 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\" \"-\""}'
     source 'nginx_td'
       time 2023-11-07 13:56:06 +0800 CST
---------
1 rows, 1 series, cost 2ms
```

#### Kubernetes sidecar Fluentd 采集 nginx 日志接入 DataKit

以Deployment 部署 Fluentd sidecar 采集 nginx 日志并转发至上级 server 端的 plugin 配置为例，我们不想直接发送到 server 端进行处理，想直接处理好并发送给 DataKit 上报至观测云平台进行分析。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sidecar-fd
  namespace: fd
  labels:
    app: webserver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
      annotations: 
    spec:
      containers:
      - name: nginx
        image: nginx:1.17.1
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
        volumeMounts: # 将logs-volume挂载到nginx容器中对应的目录，该目录为/var/log/nginx
        - name: logs-volume
          mountPath: /var/log/nginx
      - name: fluentd
        image: bitnami/fluentd:1.14.5
        #command: [ "/bin/bash", "-ce", "tail -f /dev/null" ]
        env:
        - name: FLUENT_UID
          value: fluent
        - name: FLUENT_CONF
          value: fluent.conf
        - name: FLUENTD_ARGS
          value: -c /fluentd/etc/fluentd.conf
        volumeMounts:
        - name: logs-volume
          mountPath: /var/log/nginx/
        - name: varlog
          mountPath: /var/log/
        - name: config-volume
          mountPath: /opt/bitnami/fluentd/conf/
          
      volumes:
      - name: logs-volume
        emptyDir: {}
      - name: varlog
        emptyDir: {}
      - name: config-volume
        configMap:
          name: fluentd-config

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
  namespace: fd
data:
  fluentd.conf: |
      <source>
        @type tail
        format ltsv
        path /var/log/nginx/access.log
        pos_file /var/log/nginx/posfile/access.log.pos
        tag nginx
        time_key time
        time_format %d/%b/%Y:%H:%M:%S %z
      </source>
      ##收集的数据由tcp协议转发到多个server的49875端口
      ## Multiple output
      <match nginx>
       type forward
        <server>
         name es01
         host es01
         port 49875
         weight 60
        </server>
        <server>
         name es02
         host es02
         port 49875
         weight 60
        </server>
      </match>
      ##收集的数据由http协议转发至本地 DataKit
      ## nginx output
      <match nginx>
        @type http
        endpoint http://114.55.6.167:9529/v1/write/logstreaming?source=fluentd_sidecar
        open_timeout 2
        <format>
          @type json
        </format>
      </match>

---

apiVersion: v1
kind: Service
metadata:
  name: sidecar-svc
  namespace: fd
spec:
  selector:
    app: webserver
  type: NodePort
  ports:
  - name: sidecar-port
    port: 80
    nodePort: 32004
```

对 Fluentd 挂载配置文件中 match 的 output 做修改将类型指定成 http 类型并且将 endpoint 指向开启了 **logstreaming** 的 DataKit 地址即可完成采集

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sidecar-fd
  namespace: fd
  labels:
    app: webserver
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webserver
  template:
    metadata:
      labels:
        app: webserver
      annotations: 
    spec:
      containers:
      - name: nginx
        image: nginx:1.17.1
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
        volumeMounts: # 将logs-volume挂载到nginx容器中对应的目录，该目录为/var/log/nginx
        - name: logs-volume
          mountPath: /var/log/nginx
      - name: fluentd
        image: bitnami/fluentd:1.14.5
        #command: [ "/bin/bash", "-ce", "tail -f /dev/null" ]
        env:
        - name: FLUENT_UID
          value: fluent
        - name: FLUENT_CONF
          value: fluent.conf
        - name: FLUENTD_ARGS
          value: -c /fluentd/etc/fluentd.conf
        volumeMounts:
        - name: logs-volume
          mountPath: /var/log/nginx/
        - name: varlog
          mountPath: /var/log/
        - name: config-volume
          mountPath: /opt/bitnami/fluentd/conf/
          
      volumes:
      - name: logs-volume
        emptyDir: {}
      - name: varlog
        emptyDir: {}
      - name: config-volume
        configMap:
          name: fluentd-config

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: fluentd-config
  namespace: fd
data:
  fluentd.conf: |
      <source>
        @type tail
        format ltsv
        path /var/log/nginx/access.log
        pos_file /var/log/nginx/posfile/access.log.pos
        tag nginx
        time_key time
        time_format %d/%b/%Y:%H:%M:%S %z
      </source>
      ##收集的数据由http协议转发至本地 DataKit
      ## nginx output
      <match nginx>
        @type http
        endpoint http://114.55.6.167:9529/v1/write/logstreaming?source=fluentd_sidecar
        open_timeout 2
        <format>
          @type json
        </format>
      </match>

---

apiVersion: v1
kind: Service
metadata:
  name: sidecar-svc
  namespace: fd
spec:
  selector:
    app: webserver
  type: NodePort
  ports:
  - name: sidecar-port
    port: 80
    nodePort: 32004
```

修改配置之后重新部署 yaml 文件即可完成数据上报，可以访问对应 node 的 32004 端口查看数据是否成功采集

![image](imgs/input-fluentd-3.png)

可以通过 DQL 验证上报的数据：

```shell
dql > L::nginx_td LIMIT 1
-----------------[ r1.nginx_td.s1 ]-----------------
    __docid 'L_c6et7vk5jjqulpr6osa0'
create_time 1637733374609
    date_ns 96184
       host 'df-solution-ecs-018'
    message '{"120.253.192.179 - - [24/Nov/2021":"13:55:10 +0800] \"GET / HTTP/1.1\" 304 0 \"-\" \"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\" \"-\""}'
     source 'nginx_td'
       time 2023-11-07 13:56:06 +0800 CST
---------
1 rows, 1 series, cost 2ms
```

