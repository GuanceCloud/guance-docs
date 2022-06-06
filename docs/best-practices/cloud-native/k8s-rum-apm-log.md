
# 应用场景介绍

本文用于演示的 demo 为若依权限管理系统，具体内容可查看 [[**从 0 到 1 利用 DF 构建业务系统的可观测性**](https://www.yuque.com/dataflux/bp/sample1)]

企业最重要的营收来源即是业务，而现当下，绝大多数企业的业务都是由对应的IT系统承载的，那如何保障企业的业务稳健，归根到企业内部就是如何保障企业内部的IT系统。当业务系统出现异常或故障时，往往是业务、应用开发、运维等多方面同事一起协调进行问题的排查，存在跨平台，跨部门，跨专业领域等多种问题，排查既耗时又费力，为了解决这一问题，目前业界已经比较成熟的方式即是通过 RUM+APM+LOG 实现对整个业务系统的前后端、日志进行统一监控，同时将三方数据通过关键字段进行打通，实现联动分析，从而提升相关工作人员的工作效率，保障系统平稳运行。<br />**APM**:（application performance monitoring：应用性能监控）<br />**RUM**:（real user moitoring：真实用户体验监控）<br />**LOG**：（日志）<br />本文将从如何接入这三方监控，以及如何利用 df 进行联动分析的角度进行阐述。<br />关于日志，本文将使用 datakit 的 logfwd 采集器采集业务 pod 的日志，datakit 开通 logfwd 采集器，pod 增加logfwd 的 sidecar 来采集业务容器的日志，推送给 datakit，由于业务对 sidecar 是可见的，所以日志文件不需要落到宿主机上，详细使用请在 system 模块查看。datakit接收到日志后，使用配置的 pipeline 做日志文件切割。
# 前置条件
## 账号注册
前往官方网站 [https://guance.com/](https://console.guance.com/) 注册账号，使用已注册的账号/密码登录。<br />![1631932979(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1631932989422-ea7eb977-8b4f-45a4-8df9-5accf1b36cfb.png#clientId=ub80d9813-1911-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=259&id=ub783b668&margin=%5Bobject%20Object%5D&name=1631932979%281%29.png&originHeight=517&originWidth=803&originalType=binary&ratio=1&rotation=0&showTitle=false&size=19763&status=done&style=none&taskId=u0f07d4a5-7a9f-4abb-b8e5-ed1ecba5f7e&title=&width=401.5)

---

## DaemonSet 方式部署 Datakit
### 获取 OpenWay 地址的 token 
点击 [**管理**] 模块， [**基本设置**]，复制下图中的 token。<br />![1645164696(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1645164702540-8c5d311f-53fb-42e2-a377-4184d0635dd4.png#clientId=u1181371a-a1f9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=403&id=ud34266ec&margin=%5Bobject%20Object%5D&name=1645164696%281%29.png&originHeight=604&originWidth=1741&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50248&status=done&style=none&taskId=u06d51aa9-2f2e-488f-bda0-af6b310aed6&title=&width=1160.6666666666667)<br />点击[集成]->[Datakit]->[Daemonset] 获取最新的 datakit.yaml 文件。<br />![1645164545(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1645164568630-7143d0d1-4222-4dfd-9b27-743540df341e.png#clientId=u1181371a-a1f9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=490&id=u56f6234a&margin=%5Bobject%20Object%5D&name=1645164545%281%29.png&originHeight=735&originWidth=1715&originalType=binary&ratio=1&rotation=0&showTitle=false&size=108525&status=done&style=none&taskId=u508ee905-2be4-4a8c-af9f-cfa5b608ce6&title=&width=1143.3333333333333)
### 执行安装
按照上步中的yaml文件，新建 /usr/local/k8s/datakit.yaml 文件，并把上图获取的 token，替换文件中的 <your-token>，开启 kubernetes,container 采集器，yaml 完整内容如下文。<br />『注意』下载的 datakit.yaml 并没有 ConfigMap，通过 Daemonset 安装 DataKit 时开通采集器的方式是通过 ConfigMap 定义配置，然后再通过 volume 挂载到 DataKit 容器。
```
apiVersion: v1
kind: Namespace
metadata:
  name: datakit
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterroles
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes
  - nodes/proxy
  - namespaces
  - pods
  - pods/log
  - events
  - services
  - endpoints
  - ingresses
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - batch
  resources:
  - jobs
  - cronjobs
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - metrics.k8s.io
  resources:
  - pods
  - nodes
  verbs:
  - get
  - list
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]

---

apiVersion: v1
kind: ServiceAccount
metadata:
  name: datakit
  namespace: datakit

---

apiVersion: v1
kind: Service
metadata:
  name: datakit-service
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9529
      targetPort: 9529

---

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datakit
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datakit
subjects:
- kind: ServiceAccount
  name: datakit
  namespace: datakit

---

apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: daemonset-datakit
  template:
    metadata:
      labels:
        app: daemonset-datakit
      annotations:
        datakit/logs: |
          [
            {
              "disable": true
            }
          ]
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - env:
        - name: HOST_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
        - name: ENV_GLOBAL_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-dev
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
        - name: ENV_ENABLE_ELECTION
          value: enable
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_NAMESPACE
          value: k8s-dev
        - name: ENV_LOG_LEVEL
          value: info
        image: pubrepo.jiagouyun.com/datakit/datakit:1.2.6
        imagePullPolicy: IfNotPresent
        name: datakit
        ports:
        - containerPort: 9529
          hostPort: 9529
          name: port
          protocol: TCP
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /var/run/docker.sock
          name: docker-socket
          readOnly: true
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/log/logging.conf
          name: datakit-conf
          subPath: logging.conf
        - mountPath: /usr/local/datakit/pipeline/demo_system.p
          name: datakit-conf
          subPath: log_demo_system.p
        - mountPath: /host/proc
          name: proc
          readOnly: true
        - mountPath: /host/dev
          name: dev
          readOnly: true
        - mountPath: /host/sys
          name: sys
          readOnly: true
        - mountPath: /rootfs
          name: rootfs
        - mountPath: /sys/kernel/debug
          name: debugfs
        workingDir: /usr/local/datakit
      hostIPC: true
      hostPID: true
      restartPolicy: Always
      serviceAccount: datakit
      serviceAccountName: datakit
      volumes:
      - configMap:
          name: datakit-conf
        name: datakit-conf
      - hostPath:
          path: /var/run/docker.sock
        name: docker-socket
      - hostPath:
          path: /proc
          type: ""
        name: proc
      - hostPath:
          path: /dev
          type: ""
        name: dev
      - hostPath:
          path: /sys
          type: ""
        name: sys
      - hostPath:
          path: /
          type: ""
        name: rootfs
      - hostPath:
          path: /sys/kernel/debug
          type: ""
        name: debugfs
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### container
    container.conf: |- 
      [inputs.container]
        endpoint = "unix:///var/run/docker.sock"

        ## Containers metrics to include and exclude, default not collect. Globs accepted.
        container_include_metric = []
        container_exclude_metric = ["image:*"]

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*"]
        container_exclude_log = []

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false
  
        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"



           

          
    #### logging
    logging.conf: |-
        [[inputs.logging]]
          ## required
          logfiles = [
            "/rootfs/var/log/k8s/demo-system/info.log",
            "/rootfs/var/log/k8s/demo-system/error.log",
          ]

          ## glob filteer
          ignore = [""]

          ## your logging source, if it's empty, use 'default'
          source = "k8s-demo-system"

          ## add service tag, if it's empty, use $source.
          service = "k8s-demo-system"

          ## grok pipeline script path
          pipeline = "demo_system.p"

          ## optional status:
          ##   "emerg","alert","critical","error","warning","info","debug","OK"
          ignore_status = []

          ## optional encodings:
          ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
          character_encoding = ""

          ## The pattern should be a regexp. Note the use of '''this regexp'''
          ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
          multiline_match = '''^\d{4}-\d{2}-\d{2}'''

          [inputs.logging.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
          

          
    #### system-log
    log_demo_system.p: |-
        #日志样式
        #2022-02-18 13:07:27.652 [http-nio-9201-exec-6] INFO  c.r.s.c.SysMenuController - [list,49] - demo-k8s-system 8754136045240195346 3167851246701836031 - 查询菜单列表开始

        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

        default_time(time,"Asia/Shanghai")

```
        不同的 kubernetes 集群，为区分集群内 daemonset 部署的 datakit 选举，需要增加 ENV_NAMESPACE 环境变量，同一个 token下值不能重复。同一个 token 下为区分不同的 kubernetes 集群，需要增加全局 tag，值是cluster_name_k8s=k8s-dev，这里的 k8s-dev 是集群的名称。

执行命令
```
$ cd /usr/local/k8s/
$ kubectl apply -f  datakit-default.yaml
$ kubectl get pod -n datakit
```
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1628487428623-9cdbb26f-c07c-4fda-993a-1fa5bfee05dc.png#crop=0&crop=0&crop=1&crop=1&height=50&id=uf8409849&margin=%5Bobject%20Object%5D&name=image.png&originHeight=99&originWidth=641&originalType=binary&ratio=1&rotation=0&showTitle=false&size=12405&status=done&style=none&title=&width=320.5)<br />Datakit 安装完成后，已经默认开启 Linux 主机常用插件，可以在 DF——基础设施——内置视图查看。

| 采集器名称 | 说明 |
| --- | --- |
| cpu | 采集主机的 CPU 使用情况 |
| disk | 采集磁盘占用情况 |
| diskio | 采集主机的磁盘 IO 情况 |
| mem | 采集主机的内存使用情况 |
| swap | 采集 Swap 内存使用情况 |
| system | 采集主机操作系统负载 |
| net | 采集主机网络流量情况 |
| host_process | 采集主机上常驻（存活 10min 以上）进程列表 |
| hostobject | 采集主机基础信息（如操作系统信息、硬件信息等） |
| kubernetes | 采集Kubernetes 集群指标 |
| container | 采集主机上可能的容器对象以及容器日志 |

点击 [**基础设施**] 模块，查看所有已安装 Datakit 的主机列表以及基础信息，如主机名，CPU，内存等。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625555310346-0853634b-7532-4f66-993f-d1e102a497c9.png#crop=0&crop=0&crop=1&crop=1&height=477&id=u73b558cd&margin=%5Bobject%20Object%5D&name=image.png&originHeight=954&originWidth=1901&originalType=binary&ratio=1&rotation=0&showTitle=false&size=183035&status=done&style=none&title=&width=950.5)

点击 [**主机名**] 可以查看该主机的详细系统信息，集成运行情况 (该主机所有已安装的插件)，内置视图(主机)。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625555174525-8b4b5762-e567-49e1-8ee0-e10d3328c802.png#crop=0&crop=0&crop=1&crop=1&height=453&id=u1a23a77e&margin=%5Bobject%20Object%5D&name=image.png&originHeight=906&originWidth=1521&originalType=binary&ratio=1&rotation=0&showTitle=false&size=114750&status=done&style=none&title=&width=760.5)

点击 [**集成运行情况**] 任意插件名称 [**查看监控视图**] 可以看到该插件的内置视图。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625555580831-8499535a-94db-46eb-aed5-9641e5751ca3.png#crop=0&crop=0&crop=1&crop=1&height=453&id=udd575f68&margin=%5Bobject%20Object%5D&name=image.png&originHeight=905&originWidth=1492&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103631&status=done&style=none&title=&width=746)
## 部署应用示例
### 示例说明
    web 层通过网关访问后端的 auth 和 system 服务，web 是 vue 开发的，后端是 java 开发的，示例中开启statsd 采集 jvm，示例中使用的镜像仓库是 172.16.0.215:5000，示例中使用 ddtrace 采集 java 应用的 jvm 指标，示例中使用的 nacos、redis、mysql 的内网 ip 是 172.16.0.230。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626227938361-0b8beae8-ec39-4484-af5d-0f53b13ee347.png#crop=0&crop=0&crop=1&crop=1&height=286&id=u54c64039&margin=%5Bobject%20Object%5D&name=image.png&originHeight=572&originWidth=743&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27868&status=done&style=none&title=&width=371.5)

    
### 编写 web 部署文件
把 web 应用的内容复制到 /usr/local/k8s/dist 目录。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626768609458-7da6c1a7-b898-439a-95f5-c51150278d2a.png#crop=0&crop=0&crop=1&crop=1&height=25&id=u26370e70&margin=%5Bobject%20Object%5D&name=image.png&originHeight=49&originWidth=497&originalType=binary&ratio=1&rotation=0&showTitle=false&size=5201&status=done&style=none&title=&width=248.5)

新建 /usr/local/k8s/DockerfileWeb 文件。
```
$ vim /usr/local/k8s/DockerfileWeb
```
内容如下：
```
FROM nginx:1.21.0
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /data/nginx/web/dist/
COPY ./dist/ /data/nginx/web/dist/
WORKDIR /etc/nginx
CMD ["nginx","-g","daemon off;"]
EXPOSE 80
EXPOSE 443

```
新建 /usr/local/k8s/nginx.conf，内容如下：
```
events {
    worker_connections  1024;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    sendfile        on;
    #tcp_nopush     on;

    client_max_body_size  50m;
    #keepalive_timeout  0;
    keepalive_timeout  65;
    #gzip  on;
    server {
        listen       80;
        server_name  localhost;
        
        location / {
            root  /data/nginx/web/dist;
            index  index.html index.htm;
            try_files $uri $uri/ /index.html;
        }   
         
            location /prod-api/{
            proxy_set_header Host $http_host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header REMOTE-HOST $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://172.16.0.229:30001/;
        }   
        
         location /nginx_status{
            stub_status;
         }           

        #error_page  404              /404.html;
        
        # redirect server error pages to the static page /50x.html
        #
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }   
    }   
}   
```

新建 /usr/local/k8s/web-deployment.yaml ，文件内容如下：
```
apiVersion: v1
kind: Service
metadata:
  name: web-service
  labels:
    app: web-service
spec:
  selector:
    app: web-service
  ports:
    - protocol: TCP
      port: 80
      nodePort: 30000
      targetPort: 80
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-service
  labels:
    app: web-service
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web-service
  template:
    metadata:
      labels:
        app: web-service
    spec:
      containers:
      - env:
        - name: PODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        name: web-service
        image: 47.96.6.150:5000/df-demo/demo-web:v1
        #command: ["sh","-c"]
        ports:
        - containerPort: 80
          protocol: TCP



```
### dd-java-agent 镜像
使用 java -jar 方式启动用户的jar时，需要使用 -javaagent:/usr/local/datakit/data/dd-java-agent.jar，而在用户的镜像中并不一定存在这个 jar，为了不侵入客户的业务镜像，我们需要制作一个包含 dd-java-agent.jar 的镜像，再以 Init 容器的方式先于业务容器启动，以共享存储的方式提供 dd-java-agent.jar。
```
pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0
```
本示例使用的是 sidecar 的方式，如果您想直接把jar打入镜像，请下载 [dd-java-agent](https://www.yuque.com/dataflux/datakit/ddtrace-java)，并在您的 Dockerfile 中参考下面的脚本把 jar 打入中镜像中，在部署的 yaml 中 -javaagent 使用的 jar 改成您打入的即可。
```
FROM openjdk:8u292

ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY  dd-java-agent.jar ${workdir}  #此处是把dd-java-agent打入镜像
```

### 编写 gateway 部署文件
新建 /usr/local/k8s/DockerfileGateway。
```
$ vim /usr/local/k8s/DockerfileGateway
```
文件内容如下：
```
FROM openjdk:8u292
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV jar demo-gateway.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} ${PARAMS} 2>&1 > /dev/null"]

```

新建 /usr/local/k8s/gateway-deployment.yaml ，文件内容如下：
```
apiVersion: v1
kind: Service
metadata:
  name: gateway-service
  labels:
    app: gateway-service
spec:
  selector:
    app: gateway-service
  ports:
    - protocol: TCP
      port: 9299
      nodePort: 30001
      targetPort: 9299
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gateway-service
  labels:
    app: gateway-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: gateway-service
  template:
    metadata:
      labels:
        app: gateway-service
    spec:
      containers:
      - env:
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: NACOS_IP
          value: "172.16.0.230"
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service=demo-k8s-gateway  -Ddd.tags=container_host:$(POD_NAME) -Ddd.tags=node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529   
        - name: PARAMS
          value: "--spring.redis.host=$(NACOS_IP) --spring.nacos.ip=$(NACOS_IP)"
        name: gateway-service
        image: 47.96.6.150:5000/df-demo/demo-gateway:v1
        #command: ["sh","-c"]
        ports:
        - containerPort: 9299
          protocol: TCP
        volumeMounts:
        - mountPath: /usr/dd-java-agent/agent
          name: ddagent
      initContainers:
      - command:
        - sh
        - -c
        - set -ex;mkdir -p /ddtrace/agent;cp -r /usr/dd-java-agent/agent/* /ddtrace/agent;
        image: pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0
        imagePullPolicy: Always
        name: ddtrace-agent-sidecar
        volumeMounts:
        - mountPath: /ddtrace/agent
          name: ddagent
      restartPolicy: Always
      volumes:
      - emptyDir: {}
        name: ddagent
      


```


### 编写 auth 部署文件
新建 /usr/local/k8s/DockerfileAuth。
```
$ vim  /usr/local/k8s/DockerfileAuth
```
文件内容如下：
```
FROM openjdk:8u292
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV jar demo-auth.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} ${PARAMS} 2>&1 > /dev/null"]

```

新建 /usr/local/k8s/auth-deployment.yaml ，文件内容如下：
```
apiVersion: v1
kind: Service
metadata:
  name: auth-service
  labels:
    app: auth-service
spec:
  selector:
    app: auth-service
  ports:
    - protocol: TCP
      port: 9200
      targetPort: 9200
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: auth-service
  labels:
    app: auth-service
spec:
  replicas: 2
  selector:
    matchLabels:
      app: auth-service
  template:
    metadata:
      labels:
        app: auth-service
    spec:
      containers:
      - env:
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: NACOS_IP
          value: "172.16.0.230"
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service=demo-k8s-auth  -Ddd.tags=container_host:$(POD_NAME) -Ddd.tags=node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529 
        - name: PARAMS
          value: "--spring.redis.host=$(NACOS_IP) --spring.nacos.ip=$(NACOS_IP)"
        name: auth-service
        image: 47.96.6.150:5000/df-demo/demo-auth:v1
        #command: ["sh","-c"]
        ports:
        - containerPort: 9200
          protocol: TCP
        volumeMounts:
        - mountPath: /usr/dd-java-agent/agent
          name: ddagent
      initContainers:
      - command:
        - sh
        - -c
        - set -ex;mkdir -p /ddtrace/agent;cp -r /usr/dd-java-agent/agent/* /ddtrace/agent;
        image: pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0
        imagePullPolicy: Always
        name: ddtrace-agent-sidecar
        volumeMounts:
        - mountPath: /ddtrace/agent
          name: ddagent
      restartPolicy: Always
      volumes:
      - emptyDir: {}
        name: ddagent
      


```

### 编写 system 部署文件
新建/ usr/local/k8s/DockerfileSystem。
```
$ vim /usr/local/k8s/DockerfileSystem
```
文件内容如下：
```
FROM openjdk:8u292
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV jar demo-modules-system.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}

ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS}   -jar ${jar} ${PARAMS}  2>&1 > /dev/null"]

```

新建 /usr/local/k8s/system-deployment.yaml ，pod 中使用了 3 个镜像 172.16.0.238/df-ruoyi/demo-system:v1、pubrepo.jiagouyun.com/datakit/logfwd:1.2.7、pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0，其中 dk-sidecar 是提供 dd-java-agent.jar 文件给 system-container 业务容器使用，logfwd 采集业务容器的日志文件。logfwd 的配置文件是通过 ConfigMap 来挂载到容器中的，在配置文件中指明需要采集的日志文件位置，pipeline 的名称，source 名称等。system-deployment.yaml 完整内容如下：
```
apiVersion: v1
kind: Service
metadata:
  name: system-service
spec:
  selector:
    app: system-pod
  ports:
    - protocol: TCP
      port: 9201
      #nodePort: 30001
      targetPort: 9201
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: system-deployment
  #labels:
  #  app: system-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: system-pod
  template:
    metadata:
      labels:
        app: system-pod
    spec:
      #nodeName: k8s-node1              
      containers:
      - name: system-container      
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: NACOS_IP
          value: "172.16.0.229"
        - name: DB_IP
          value: "172.16.0.230"
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service=demo-k8s-system  -Ddd.tags=container_host:$(PODE_NAME)  -Ddd.tags=node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=mysql:mysql-k8s,redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529 
        - name: PARAMS
          value: "--spring.redis.host=$(DB_IP) --spring.nacos.ip=$(NACOS_IP) --spring.db.ip=$(DB_IP)"
        image: 172.16.0.238/df-ruoyi/demo-system:v1
        #command: ["sh","-c"]
        ports:
        - containerPort: 9201
          protocol: TCP
        volumeMounts:
        - name: ddagent
          mountPath: /usr/dd-java-agent/agent
        - name: varlog
          mountPath: /data/app/logs/ruoyi-system
        resources:
          limits: 
            memory: 512Mi
          requests:
            memory: 256Mi
      - name: logfwd
        image: pubrepo.jiagouyun.com/datakit/logfwd:1.2.7
        env:
        - name: LOGFWD_DATAKIT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: LOGFWD_DATAKIT_PORT
          value: "9531"
        - name: LOGFWD_LOGFWD_ANNOTATION_DATAKIT_LOG_CONFIGS
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.annotations['datakit/log']
        - name: LOGFWD_POD_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.name
        - name: LOGFWD_POD_NAMESPACE
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace  
        volumeMounts:
        - mountPath: /var/log
          name: varlog 
        - mountPath: /opt/logfwd/config
          name: logfwd-config
          subPath: config               
      initContainers:
      - name: ddtrace-agent-sidecar
        command:
        - sh
        - -c
        - set -ex;mkdir -p /ddtrace/agent;cp -r /usr/dd-java-agent/agent/* /ddtrace/agent;
        image: pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0
        imagePullPolicy: Always
        volumeMounts:
        - mountPath: /ddtrace/agent
          name: ddagent
      restartPolicy: Always
      volumes:
      - name: varlog
        emptyDir: {} 
      - name: ddagent
        emptyDir: {} 
      - configMap:
          name: logfwd-conf
        name: logfwd-config 
          
---
        
apiVersion: v1
kind: ConfigMap
metadata:
  name: logfwd-conf
data:
  config: |
    [
        {            
            "loggings": [
                {
                    "logfiles": ["/var/log/info.log","/var/log/error.log"],
                    "source": "k8s-log-system",                    
                    "pipeline": "log_demo_system.p",
                    "multiline_match": "^\\d{4}-\\d{2}-\\d{2}"
                }
            ]
        }
    ] 
```
另外 system-deployment.yaml 文件中使用了环境变量来指定 datakit 和 logfwd 端口。<br />环境变量说明：

- LOGFWD_DATAKIT_HOST:  datakit地址。
- LOGFWD_DATAKIT_PORT:  logfwd 端口

logfwd-conf参数说明：

- logfiles:  日志文件列表。
- ignore:  文件路径过滤，使用 glob 规则，符合任意一条过滤条件将不会对该文件进行采集。
- source:   数据来源。
- service:  新增标记 tag，如果为空，则默认使用 $source。
- pipeline:  使用 pipeline 时，定义脚本路径。
- character_encoding:  选择编码。
- multiline_match:  多行匹配。
- remove_ansi_escape_codes:  是否删除 ANSI 转义码，例如标准输出的文本颜色等，值为 true 或 false。

### 链路数据增加 node_ip 标签
在 datakit.yaml 增加 ConfigMap：
```
ddtrace.conf: |- 
  [[inputs.ddtrace]]
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    # ignore_resources = []
    customer_tags = ["node_ip"]
```
volumeMounts 下面增加：
```
- mountPath: /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
  name: datakit-conf
  subPath: ddtrace.conf  
```

---


# 用户访问监测 (RUM)
## 
### 新建应用
•登录[观测云平台]<br />•选择[**用户访问监测**]-[**新建应用**]-[**选择 web 类型**]-[**同步载入**] 应用名称输入 web-k8s-demo<br />![1640077907(1).png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1640077919066-74ca8576-5d05-488a-b929-8075d59181c8.png#clientId=u8fef948c-8af6-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=375&id=u518e0c18&margin=%5Bobject%20Object%5D&name=1640077907%281%29.png&originHeight=749&originWidth=917&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38388&status=done&style=none&taskId=u1fe596a2-5279-452a-8747-a7e33349452&title=&width=458.5)
### 开通前端 RUM 监控
Datakit 默认开启了 RUM 采集器，用户访问监测使用的 Datakit 地址，需要客户的网络能够访问到的地址，需要修改 Datakit 的配置文件 /usr/local/datakit/conf.d/datakit.conf 的 listen="0.0.0.0:9529"。本示例使用的 Datakit 是 DaemonSet 方式部署的，已经修改了默认的配置。实际生产中 RUM 使用的 Datakit 建议部署到 kubernetes 外部。<br />修改 /usr/local/k8s/dist/index.html 文件，在 head 中增加如下内容：
```
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'appid_ddxxxxxxxxxxxxxxxxxx5',
      datakitOrigin: 'http://172.16.0.230:9529',
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      traceType: 'ddtrace',
      allowedTracingOrigins: ["http://8.136.207.182:30000","http://8.136.193.105:30000","http://8.136.204.98:30000"] 
    })
</script>
```
**applicationId: **应用 id。<br />**datakitOrigin: **是用户可访问到的 datakit 的地址或域名，这里的 172.16.0.23 0是 k8s 的 node1 的 ip 地址。<br />**env: **必填，应用所属环境，是 test 或 product 或其他字段。<br />**version: **必填，应用所属版本号。<br />**allowedDDTracingOrigins: **RUM 与 APM 打通，配置后端服务器地址或域名，由于本示例前端和后端访问地址都是 [http://8.136.193.105:30000/](http://8.136.193.105:30000/)，在配置时需要把 30000 端口加上。<br />**trackInteractions:** 用户行为统计，例如点击按钮，提交信息等动作。<br />**traceType: **非必填，默认为ddtrace，目前支持 ddtrace、zipkin、skywalking_v3、jaeger、zipkin_single_header、w3c_traceparent 6种类型。<br />需要详细了解用户访问监测，请访问 [web 应用监控 (RUM) 最佳实践](https://www.yuque.com/dataflux/bp/web)。
### 
# 应用性能监测 (APM)
### 开通 ddtrace

修改 /usr/local/k8s/datakit.yaml 文件中的 ENV_ENABLE_INPUTS，增加 ddtrace
```
 - name: ENV_ENABLE_INPUTS
   value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,ddtrace
        
```
### Java 应用接入 ddtrace

在制作 system 镜像文件 DockerfileSystem 中，启动 jar 的命令是：
```
exec java ${JAVA_OPTS}   -jar ${jar}
```
环境变量 JAVA_OPTS 在部署文件 system-deployment.yaml 中有如下定义：
```
- name: JAVA_OPTS
  value: |-
    -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service=demo-k8s-system  -Ddd.tags=container_host:$(POD_NAME) -Ddd.service.mapping=mysql:mysql-k8s,redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529  
        

```

JAVA_OPTS 详细说明：
```
-Ddd.env：应用的环境类型，选填 
-Ddd.tags：自定义标签，选填    
-Ddd.service：JVM数据来源的应用名称，必填  
-Ddd.agent.host=localhost    DataKit 地址，选填  
-Ddd.agent.port=9529         DataKit 端口，必填  
-Ddd.version:版本，选填 
-Ddd.jmxfetch.check-period 表示采集频率，单位为毫秒，默认 true，选填   
-Ddd.jmxfetch.statsd.host=127.0.0.1 statsd 采集器的连接地址同 DataKit 地址，选填  
-Ddd.jmxfetch.statsd.port=8125 表示 DataKit 上 statsd 采集器的 UDP 连接端口，默认为 8125，选填   
-Ddd.trace.health.metrics.statsd.host=127.0.0.1  自身指标数据采集发送地址同 DataKit 地址，选填 
-Ddd.trace.health.metrics.statsd.port=8125  自身指标数据采集发送端口，选填   
-Ddd.service.mapping:应用调用的 redis、mysql 等别名，选填 
```
『注意』 JAVA_OPTS 中并没有指定链路数据上报到的 DataKit 地址，而是通过在 yaml 中定义环境变量 DD_AGENT_HOST 来指定链路数据上报的 DataKit 地址。在 Kubernetes 集群中，链路数据上报的原则是 POD 链路数据上报到部署在同宿主机内的 DataKit 上，详细配置请参考 system-deployment.yaml。
```
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
```
### 设置跨域请求白名单
response.headers.add('Access-Control-Allow-Headers','x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')

# 日志
### 配置 logback.xml
![1645164334(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1645164334662-47628f04-c2ac-41f8-b333-e18aa4226383.png#clientId=u1181371a-a1f9-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=444&id=uc90bdcbb&margin=%5Bobject%20Object%5D&name=1645164334%281%29.png&originHeight=666&originWidth=1224&originalType=binary&ratio=1&rotation=0&showTitle=false&size=92620&status=done&style=none&taskId=ua6615e8a-30aa-4bd9-967a-4b15f2ebf38&title=&width=816)
### 日志分割 pipeline
使用 pipeline 分割 system 系统生成的日志，再用 configMap 挂载 pipeline，DaemonSet 部署 datakit 后，会在 /usr/local/datakit/pipeline/ 目录生成 demo_system.p 文件。由于本应用容器时区使用的东八区，这里要做一下时区转换，datakit.yaml 中增加如下内容：
```
     log_demo_system.p: |-
        #日志样式
        #2022-02-18 13:07:27.652 [http-nio-9201-exec-6] INFO  c.r.s.c.SysMenuController - [list,49] - demo-k8s-system 8754136045240195346 3167851246701836031 - 查询菜单列表开始

        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

        default_time(time,"Asia/Shanghai")
        #default_time(time)
```
volumeMounts 下面增加：
```
- mountPath: /usr/local/datakit/pipeline/demo_system.p
  name: datakit-conf
  subPath: log-demo-system.p
```

### 开启 log 采集
kubernetes 日志采集，推荐使用 datakit 的 logfwd 采集器，
```
    logfwdserver.conf: |-
      [inputs.logfwdserver]
        ## logfwd 接收端监听地址和端口
        address = "0.0.0.0:9531"

        [inputs.logfwdserver.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
```

volumeMounts 下面增加：
```
        - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
          name: datakit-conf
          subPath: logfwdserver.conf    
```
### 完整 datakit.yaml
【注意】不同 datakit 版本之间配置有差异，建议参照对应的版本配置 datakit
```
apiVersion: v1
kind: Namespace
metadata:
  name: datakit
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: datakit
rules:
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterroles
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes
  - nodes/proxy
  - namespaces
  - pods
  - pods/log
  - events
  - services
  - endpoints
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - batch
  resources:
  - jobs
  - cronjobs
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - metrics.k8s.io
  resources:
  - pods
  - nodes
  verbs:
  - get
  - list
- nonResourceURLs: ["/metrics"]
  verbs: ["get"]

---

apiVersion: v1
kind: ServiceAccount
metadata:
  name: datakit
  namespace: datakit

---

apiVersion: v1
kind: Service
metadata:
  name: datakit-service
  namespace: datakit
spec:
  selector:
    app: daemonset-datakit
  ports:
    - protocol: TCP
      port: 9529
      targetPort: 9529

---

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: datakit
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: datakit
subjects:
- kind: ServiceAccount
  name: datakit
  namespace: datakit

---

apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: daemonset-datakit
  name: datakit
  namespace: datakit
spec:
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: daemonset-datakit
  template:
    metadata:
      labels:
        app: daemonset-datakit
      annotations:
        datakit/logs: |
          [
            {
              "disable": true
            }
          ]
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - env:
        - name: HOST_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
        - name: ENV_DATAWAY
          value: https://openway.guance.com?token=<your-token>
        - name: ENV_GLOBAL_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-dev
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd
        - name: ENV_ENABLE_ELECTION
          value: enable
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_NAMESPACE
          value: k8s-dev
        - name: ENV_LOG_LEVEL
          value: info
        image: pubrepo.jiagouyun.com/datakit/datakit:1.2.6
        imagePullPolicy: IfNotPresent
        name: datakit
        ports:
        - containerPort: 9529
          hostPort: 9529
          name: port
          protocol: TCP
        securityContext:
          privileged: true
        volumeMounts:
        - mountPath: /var/run/docker.sock
          name: docker-socket
          readOnly: true
        - mountPath: /usr/local/datakit/conf.d/container/container.conf
          name: datakit-conf
          subPath: container.conf
        - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
          name: datakit-conf
          subPath: logfwdserver.conf
        - mountPath: /usr/local/datakit/pipeline/demo_system.p
          name: datakit-conf
          subPath: log_demo_system.p
        - mountPath: /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
          name: datakit-conf
          subPath: ddtrace.conf  
        - mountPath: /host/proc
          name: proc
          readOnly: true
        - mountPath: /host/dev
          name: dev
          readOnly: true
        - mountPath: /host/sys
          name: sys
          readOnly: true
        - mountPath: /rootfs
          name: rootfs
        - mountPath: /sys/kernel/debug
          name: debugfs
        workingDir: /usr/local/datakit
      hostIPC: true
      hostPID: true
      restartPolicy: Always
      serviceAccount: datakit
      serviceAccountName: datakit
      volumes:
      - configMap:
          name: datakit-conf
        name: datakit-conf
      - hostPath:
          path: /var/run/docker.sock
        name: docker-socket
      - hostPath:
          path: /proc
          type: ""
        name: proc
      - hostPath:
          path: /dev
          type: ""
        name: dev
      - hostPath:
          path: /sys
          type: ""
        name: sys
      - hostPath:
          path: /
          type: ""
        name: rootfs
      - hostPath:
          path: /sys/kernel/debug
          type: ""
        name: debugfs
  updateStrategy:
    rollingUpdate:
      maxUnavailable: 1
    type: RollingUpdate
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #### container
    container.conf: |- 
      [inputs.container]
        endpoint = "unix:///var/run/docker.sock"

        ## Containers metrics to include and exclude, default not collect. Globs accepted.
        container_include_metric = []
        container_exclude_metric = ["image:*"]

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = ["image:*"]
        container_exclude_log = []

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false
  
        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        [inputs.container.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value" 

    #### ddtrace
    ddtrace.conf: |- 
      [[inputs.ddtrace]]
        endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
        # ignore_resources = []
        customer_tags = ["node_ip"]

        ## tags is ddtrace configed key value pairs
        # [inputs.ddtrace.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
    #### logfwdserver
    logfwdserver.conf: |-
      [inputs.logfwdserver]
        ## logfwd 接收端监听地址和端口
        address = "0.0.0.0:9531"

        [inputs.logfwdserver.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"        

          
    #### system-log
    log_demo_system.p: |-
        #日志样式
        #2022-02-18 13:07:27.652 [http-nio-9201-exec-6] INFO  c.r.s.c.SysMenuController - [list,49] - demo-k8s-system 8754136045240195346 3167851246701836031 - 查询菜单列表开始

        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

        default_time(time,"Asia/Shanghai")

```

# 部署应用
### 制作镜像并上传到 harbor 仓库
```
$ cd /usr/local/k8s/
$ docker build -t 172.16.0.215:5000/df-demo/demo-web:v1 -f DockerfileWeb .
$ docker push 172.16.0.215:5000/df-demo/demo-web:v1

$ docker build -t 172.16.0.215:5000/df-demo/demo-gateway:v1 -f DockerfileGateway .
$ docker push 172.16.0.215:5000/df-demo/demo-gateway:v1

$ docker build -t 172.16.0.215:5000/df-demo/demo-auth:v1 -f DockerfileAuth .
$ docker push 172.16.0.215:5000/df-demo/demo-auth:v1

$ docker build -t 172.16.0.215:5000/df-demo/demo-system:v1 -f DockerfileSystem .
$ docker push 172.16.0.215:5000/df-demo/demo-system:v1
```
### 
### 部署
```
$ cd /usr/local/k8s/
$ kubectl apply -f web-deployment.yaml
$ kubectl apply -f gateway-deployment.yaml
$ kubectl apply -f auth-deployment.yaml
$ kubectl apply -f system-deployment.yaml
```


![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626767442674-caa7277d-d091-45b8-883b-79f8de3e58d0.png#crop=0&crop=0&crop=1&crop=1&height=526&id=u597eee32&margin=%5Bobject%20Object%5D&name=image.png&originHeight=1051&originWidth=1816&originalType=binary&ratio=1&rotation=0&showTitle=false&size=185165&status=done&style=none&title=&width=908)

# 链路分析

### RUM APM 联动
访问 web 应用，点击【系统管理】->【用户管理】，此时触发用户列表查询请求 list，dataflux-rum.js 会生成trace-id 存入 header 中，可以看到 list 接口对应的 trace-id 是 1373630955948661374。请求调用后端的 list 接口，后端的 ddtrace 会读取到 trace-id 并记录到自己的 trace 数据里，在 logback.xml 增加了 %X{dd.trace_id}，trace_id 会随日志输出，从而实现了 RUM、APM 和 Log 的联动。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626081845609-d45c0829-5c3f-4865-af89-e4dfc28b10f0.png#crop=0&crop=0&crop=1&crop=1&height=461&id=u2b1c4a64&margin=%5Bobject%20Object%5D&name=image.png&originHeight=922&originWidth=1897&originalType=binary&ratio=1&rotation=0&showTitle=false&size=173421&status=done&style=none&title=&width=948.5)

点击【用户访问监测】模块->【web-k8s-demo】->【查看器】->选择 view，点击列表中的 /system/user

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626081709413-c94edc51-8d46-420e-a002-900a93892f9e.png#crop=0&crop=0&crop=1&crop=1&height=386&id=u21718810&margin=%5Bobject%20Object%5D&name=image.png&originHeight=771&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=142927&status=done&style=none&title=&width=960)

点击【链路】

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626081718563-388097c6-c70a-45f8-854d-eb19d9d1aac8.png#crop=0&crop=0&crop=1&crop=1&height=344&id=u17507aa7&margin=%5Bobject%20Object%5D&name=image.png&originHeight=688&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=116110&status=done&style=none&title=&width=960)<br />点击上图中的【prod-api/system/user/list】，prod-api 是 nginx 增加的转发请求，/system/user/list 是后端的 api 接口，进去后可以看到具体的请求及耗时情况。

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1626081732208-642a51ed-31b2-4beb-8512-9cfc8d8f56fe.png#crop=0&crop=0&crop=1&crop=1&height=447&id=uea252a0a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=894&originWidth=1862&originalType=binary&ratio=1&rotation=0&showTitle=false&size=136372&status=done&style=none&title=&width=931)

### 日志分析
点击【日志】 模块，选择全部来源，搜索栏输入“查询”，回车，默认查询最近 15 分钟的日志。点击查询记录，根据 logback.xml 配置找到对应 trace_id 是 704229736283371775<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625825456270-65f72041-365f-4473-9129-1027c7fc3204.png#crop=0&crop=0&crop=1&crop=1&height=405&id=uf85a8c55&margin=%5Bobject%20Object%5D&name=image.png&originHeight=810&originWidth=1907&originalType=binary&ratio=1&rotation=0&showTitle=false&size=140166&status=done&style=none&title=&width=953.5)

点击【应用性能监控】模块->点击【链路】筛选框输入 trace_id:704229736283371775，回车检索出链路的调用情况。

![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625825645908-7230ae74-42a4-4cc7-a89a-2b239df4973b.png#crop=0&crop=0&crop=1&crop=1&height=356&id=ub2eb60cf&margin=%5Bobject%20Object%5D&name=image.png&originHeight=711&originWidth=1890&originalType=binary&ratio=1&rotation=0&showTitle=false&size=122325&status=done&style=none&title=&width=945)<br />点击【SysUserController.list】查看详细信息。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21583952/1625825697898-b4850294-608d-4160-8dbb-283944b4e24f.png#crop=0&crop=0&crop=1&crop=1&height=451&id=u1f6f3a7f&margin=%5Bobject%20Object%5D&name=image.png&originHeight=901&originWidth=1866&originalType=binary&ratio=1&rotation=0&showTitle=false&size=131951&status=done&style=none&title=&width=933)






## 
