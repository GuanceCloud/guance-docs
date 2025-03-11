---
title: 'Fluentd'
summary: 'Collect logs from Fluentd'
__int_icon: 'icon/fluentd'
---

<!-- markdownlint-disable MD025 -->
# Fluentd Logs
<!-- markdownlint-enable -->

Fluentd log collection involves accepting log text data and reporting it to Guance.

## Installation and Deployment {#config}

### Prerequisites

- td-agent-4.2.x >= 4.2.x
- Verify that Fluentd data is being collected correctly

### Collector Configuration

Navigate to the `conf.d/log` directory under the DataKit installation directory, copy `logstreaming.conf.sample` and rename it to `logstreaming.conf`. Example:

```yaml
[inputs.logstreaming]
  ignore_url_tags = true
```

Restart DataKit

```yaml
systemctl restart datakit
```

#### Linux Fluentd Collecting Nginx Logs into DataKit

Using Fluentd to collect nginx logs and forward them to an upstream server via a plugin configuration example. Instead of sending directly to the server for processing, we want to process and send the data directly to DataKit for analysis on the Guance platform.

```yaml
## PC Log Collection
<source>
  @type tail
  format ltsv
  path /var/log/nginx/access.log
  pos_file /var/log/buffer/posfile/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>

## Forward collected data to multiple servers on port 49875 using TCP protocol
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

Modify the match output to specify the type as http and direct the endpoint to the DataKit address with **logstreaming** enabled to complete the collection.

```yaml
## PC Log Collection
<source>
  @type tail
  format ltsv
  path /var/log/nginx/access.log
  pos_file /var/log/buffer/posfile/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>

## Forward collected data to local DataKit using HTTP protocol
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

After modifying the configuration, restart td-agent to complete data reporting.

![image](imgs/input-fluentd-1.png)

You can verify the reported data using DQL:

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

#### Windows Fluentd Collecting Nginx Logs into DataKit

Using Fluentd to collect nginx logs and forward them to an upstream server via a plugin configuration example. Instead of sending directly to the server for processing, we want to process and send the data directly to DataKit for analysis on the Guance platform.

```bash
## PC Log Collection
<source>
  @type tail
  format ltsv
  path D://opt/nginx/log/access.log
  pos_file D://opt/nginx/log/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>

## Forward collected data to multiple servers on port 49875 using TCP protocol
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

Modify the match output to specify the type as http and direct the endpoint to the DataKit address with **logstreaming** enabled to complete the collection.

```yaml
## PC Log Collection
<source>
  @type tail
  format ltsv
  path D://opt/nginx/log/access.log
  pos_file D://opt/nginx/log/access.log.pos
  tag nginx
  time_key time
  time_format %d/%b/%Y:%H:%M:%S %z
</source>

## Forward collected data to local DataKit using HTTP protocol
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

After modifying the configuration, restart `fluentd -c` the modified configuration file to complete data reporting.

![image](imgs/input-fluentd-2.png)

You can verify the reported data using DQL:

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

#### Kubernetes Sidecar Fluentd Collecting Nginx Logs into DataKit

Using a Deployment to deploy Fluentd sidecar to collect nginx logs and forward them to an upstream server via a plugin configuration example. Instead of sending directly to the server for processing, we want to process and send the data directly to DataKit for analysis on the Guance platform.

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
        volumeMounts: # Mount logs-volume to the corresponding directory in the nginx container, which is /var/log/nginx
        - name: logs-volume
          mountPath: /var/log/nginx
      - name: fluentd
        image: bitnami/fluentd:1.14.5
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
      ## Forward collected data to multiple servers on port 49875 using TCP protocol
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
      ## Forward collected data to local DataKit using HTTP protocol
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

Modify the match output in the mounted Fluentd configuration file to specify the type as http and direct the endpoint to the DataKit address with **logstreaming** enabled to complete the collection.

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
        volumeMounts: # Mount logs-volume to the corresponding directory in the nginx container, which is /var/log/nginx
        - name: logs-volume
          mountPath: /var/log/nginx
      - name: fluentd
        image: bitnami/fluentd:1.14.5
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
      ## Forward collected data to local DataKit using HTTP protocol
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

After modifying the configuration, redeploy the YAML file to complete data reporting. You can access the 32004 port on the corresponding node to check if the data has been successfully collected.

![image](imgs/input-fluentd-3.png)

You can verify the reported data using DQL:

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
