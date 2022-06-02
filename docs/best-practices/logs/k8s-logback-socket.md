# 应用场景介绍
Logback日志输出除了常用的file和stdout外，还可以进行socket（TCP）输出，基于socket日志上报最大的优势在于降低了存储费用，程序生成的日志在本地进行一部分内存缓冲继而上报到采集端。同样datakit也支持socket日志采集。本文主要介绍基于K8s下springboot应用将日志通过logback socket方式推送至观测云平台进行观测。

# 前置条件

1. 您需要先创建一个[观测云账号](https://www.guance.com/)。
1. springboot应用。
1. docker-harbor。
1. k8s集群。

# 安装部署
## K8s下Datakit 安装配置
K8s下Datakit 安装参照文档[**Kubernetes应用的RUM-APM-LOG联动分析**](https://www.yuque.com/dataflux/bp/k8s-rum-apm-log#HGQ8d)。
#### 
### 配置日志采集文件logging-socket-demo.conf 
接收日志，需要开启log socket，开启一个9541端口，并配置pipeline解析。
> [[inputs.logging]]
>           ## required
>         #  logfiles = [
>         #    "/var/log/syslog",
>         #    "/var/log/message",
>         #  ]
>           # only two protocols are supported:TCP and UDP
>           sockets = [
>                  "tcp://0.0.0.0:9541",
>           #      "udp://0.0.0.0:9531",
>           ]
>           ## glob filteer
>           ignore = [""]
> 
>           ## your logging source, if it's empty, use 'default'
>           source = "socket_log"
> 
>           ## add service tag, if it's empty, use $source.
>           service = "socket_service"
> 
>           ## grok pipeline script name
>           pipeline = "logback_socket_pipeline.p"
> 
>           ## optional status:
>           ##   "emerg","alert","critical","error","warning","info","debug","OK"
>           ignore_status = []
> 
>           ## optional encodings:
>           ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
>           character_encoding = ""
> 
>           ## The pattern should be a regexp. Note the use of '''this regexp'''
>           ## regexp link: [https://golang.org/pkg/regexp/syntax/#hdr-Syntax](https://golang.org/pkg/regexp/syntax/#hdr-Syntax)
>           # multiline_match = '''^\S'''
> 
>           ## removes ANSI escape codes from text strings
>           remove_ansi_escape_codes = false
> 
>           [inputs.logging.tags]
>             service = "socket-demo"


### pipeline解析日志
 logback_socket_pipeline.p 用于解析socket日志格式，便于您在观测云平台查看使用。全文如下：
> **        #------------------------------------   警告   -------------------------------------**
> **        # 不要修改本文件，如果要更新，请拷贝至其它文件，最好以某种前缀区分，避免重启后被覆盖**
> **        #-----------------------------------------------------------------------------------        **
> **        # access log**
> **        json(_,msg,"message")**
> **        json(_,class,"class")**
> **        json(_,appName,"service")**
> **        json(_,thread,"thread")**
> **        json(_,severity,"status")**
> **        json(_,trace,"trace_id")**
> **        json(_,span,"span_id")**
> **        json(_,`@timestamp`,"time")**
> **        default_time(time)**


### datakit.yaml 全文
配置如下，需要将token修改成您自己的token。
> apiVersion: v1
> kind: Namespace
> metadata:
>   name: datakit
> ---
> apiVersion: rbac.authorization.k8s.io/v1
> kind: ClusterRole
> metadata:
>   name: datakit
> rules:
> - apiGroups:
>   - rbac.authorization.k8s.io
>   resources:
>   - clusterroles
>   verbs:
>   - get
>   - list
>   - watch
> - apiGroups:
>   - ""
>   resources:
>   - nodes
>   - nodes/proxy
>   - namespaces
>   - pods
>   - pods/log
>   - events
>   - services
>   - endpoints
>   - ingresses
>   verbs:
>   - get
>   - list
>   - watch
> - apiGroups:
>   - apps
>   resources:
>   - deployments
>   - daemonsets
>   - statefulsets
>   - replicasets
>   verbs:
>   - get
>   - list
>   - watch
> - apiGroups:
>   - batch
>   resources:
>   - jobs
>   - cronjobs
>   verbs:
>   - get
>   - list
>   - watch
> - apiGroups:
>   - metrics.k8s.io
>   resources:
>   - pods
>   - nodes
>   verbs:
>   - get
>   - list
> - nonResourceURLs: ["/metrics"]
>   verbs: ["get"]
> 
> ---
> 
> apiVersion: v1
> kind: ServiceAccount
> metadata:
>   name: datakit
>   namespace: datakit
> 
> ---
> 
> apiVersion: v1
> kind: Service
> metadata:
>   name: datakit-service
>   namespace: datakit
> spec:
>   selector:
>     app: daemonset-datakit
>   ports:
>     - protocol: TCP
>       port: 9529
>       targetPort: 9529
> 
> ---
> 
> apiVersion: rbac.authorization.k8s.io/v1
> kind: ClusterRoleBinding
> metadata:
>   name: datakit
> roleRef:
>   apiGroup: rbac.authorization.k8s.io
>   kind: ClusterRole
>   name: datakit
> subjects:
> - kind: ServiceAccount
>   name: datakit
>   namespace: datakit
> 
> ---
> 
> apiVersion: apps/v1
> kind: DaemonSet
> metadata:
>   labels:
>     app: daemonset-datakit
>   name: datakit
>   namespace: datakit
> spec:
>   revisionHistoryLimit: 10
>   selector:
>     matchLabels:
>       app: daemonset-datakit
>   template:
>     metadata:
>       labels:
>         app: daemonset-datakit
>       annotations:
>         datakit/logs: |
>           [
>             {
>               "disable": true
>             }
>           ]
>     spec:
>       hostNetwork: true
>       dnsPolicy: ClusterFirstWithHostNet
>       containers:
>       - env:
>         - name: HOST_IP
>           valueFrom:
>             fieldRef:
>               apiVersion: v1
>               fieldPath: status.hostIP
>         - name: NODE_NAME
>           valueFrom:
>             fieldRef:
>               apiVersion: v1
>               fieldPath: spec.nodeName
>         - name: ENV_DATAWAY
>           value: [https://openway.guance.com?token=](https://openway.guance.com?token=tkn_d01d5c94adbc46f598310d5e1bd2f6e7)<you token>
>         - name: ENV_GLOBAL_TAGS
>           value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name=k8s-dev
>         - name: ENV_DEFAULT_ENABLED_INPUTS
>           value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ddtrace
>         - name: ENV_ENABLE_ELECTION
>           value: enable
>         - name: ENV_HTTP_LISTEN
>           value: 0.0.0.0:9529
>         - name: ENV_LOG_LEVEL
>           value: info
>         image: pubrepo.jiagouyun.com/datakit/datakit:1.2.6
>         imagePullPolicy: IfNotPresent
>         name: datakit
>         ports:
>         - containerPort: 9529
>           hostPort: 9529
>           name: port
>           protocol: TCP
>         securityContext:
>           privileged: true
>         volumeMounts:
>         - mountPath: /var/run/docker.sock
>           name: docker-socket
>           readOnly: true
>         - mountPath: /usr/local/datakit/conf.d/container/container.conf
>           name: datakit-conf
>           subPath: container.conf
>         #- mountPath: /usr/local/datakit/conf.d/log/logging.conf
>         #  name: datakit-conf
>         #  subPath: logging.conf
>         - mountPath: /usr/local/datakit/pipeline/demo_system.p
>           name: datakit-conf
>           subPath: log_demo_system.p
> **        - mountPath: /usr/local/datakit/conf.d/log/logging-socket-demo.conf**
> **          name: datakit-conf**
> **          subPath: logging-socket-demo.conf**
> **        - mountPath: /usr/local/datakit/pipeline/logback_socket_pipeline.p**
> **          name: datakit-conf**
> **          subPath: logback_socket_pipeline.p       **
>         - mountPath: /host/proc
>           name: proc
>           readOnly: true
>         - mountPath: /host/dev
>           name: dev
>           readOnly: true
>         - mountPath: /host/sys
>           name: sys
>           readOnly: true
>         - mountPath: /rootfs
>           name: rootfs
>         - mountPath: /sys/kernel/debug
>           name: debugfs
>         workingDir: /usr/local/datakit
>       hostIPC: true
>       hostPID: true
>       restartPolicy: Always
>       serviceAccount: datakit
>       serviceAccountName: datakit
>       volumes:
>       - configMap:
>           name: datakit-conf
>         name: datakit-conf
>       - hostPath:
>           path: /var/run/docker.sock
>         name: docker-socket
>       - hostPath:
>           path: /proc
>           type: ""
>         name: proc
>       - hostPath:
>           path: /dev
>           type: ""
>         name: dev
>       - hostPath:
>           path: /sys
>           type: ""
>         name: sys
>       - hostPath:
>           path: /
>           type: ""
>         name: rootfs
>       - hostPath:
>           path: /sys/kernel/debug
>           type: ""
>         name: debugfs
>   updateStrategy:
>     rollingUpdate:
>       maxUnavailable: 1
>     type: RollingUpdate
> ---
> apiVersion: v1
> kind: ConfigMap
> metadata:
>   name: datakit-conf
>   namespace: datakit
> data:
>     #### container
>     container.conf: |- 
>       [inputs.container]
>         endpoint = "unix:///var/run/docker.sock"
> 
>         ## Containers metrics to include and exclude, default not collect. Globs accepted.
>         container_include_metric = []
>         container_exclude_metric = ["image:*"]
> 
>         ## Containers logs to include and exclude, default collect all containers. Globs accepted.
>         container_include_log = ["image:*"]
>         container_exclude_log = []
> 
>         exclude_pause_container = true
> 
>         ## Removes ANSI escape codes from text strings
>         logging_remove_ansi_escape_codes = false
>   
>         kubernetes_url = "https://kubernetes.default:443"
> 
>         ## Authorization level:
>         ##   bearer_token -> bearer_token_string -> TLS
>         ## Use bearer token for authorization. ('bearer_token' takes priority)
>         ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
>         ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
>         bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
>         # bearer_token_string = "<your-token-string>"
> 
>         [inputs.container.tags]
>           # some_tag = "some_value"
>           # more_tag = "some_other_value"
> 
>           
>     #### logging
>     logging.conf: |-
>         [[inputs.logging]]
>           ## required
>           logfiles = [
>             "/rootfs/var/log/k8s/ruoyi-system/info.log",
>             "/rootfs/var/log/k8s/ruoyi-system/error.log",
>           ]
> 
>           ## glob filteer
>           ignore = [""]
> 
>           ## your logging source, if it's empty, use 'default'
>           source = "k8s-demo-system1"
> 
>           ## add service tag, if it's empty, use $source.
>           service = "k8s-demo-system1"
> 
>           ## grok pipeline script path
>           pipeline = "demo_system.p"
> 
>           ## optional status:
>           ##   "emerg","alert","critical","error","warning","info","debug","OK"
>           ignore_status = []
> 
>           ## optional encodings:
>           ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
>           character_encoding = ""
> 
>           ## The pattern should be a regexp. Note the use of '''this regexp'''
>           ## regexp link: [https://golang.org/pkg/regexp/syntax/#hdr-Syntax](https://golang.org/pkg/regexp/syntax/#hdr-Syntax)
>           multiline_match = '''^\d{4}-\d{2}-\d{2}'''
> 
>           [inputs.logging.tags]
>           # some_tag = "some_value"
>           # more_tag = "some_other_value"
>           
> 
>           
>     #### system-log
>     log_demo_system.p: |-
>         #日志样式
>         #2021-06-25 14:27:51.952 [http-nio-9201-exec-7] INFO  c.r.s.c.SysUserController - [list,70] ruoyi-08-system 5430221015886118174 6503455222153372731 - 查询用户
> 
>         grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")
> 
>         default_time(time,"Asia/Shanghai")
>         
>         
>     **logback_socket_pipeline.p: |-**
> **        #------------------------------------   警告   -------------------------------------**
> **        # 不要修改本文件，如果要更新，请拷贝至其它文件，最好以某种前缀区分，避免重启后被覆盖**
> **        #-----------------------------------------------------------------------------------        **
> **        # access log**
> **        json(_,msg,"message")**
> **        json(_,class,"class")**
> **        json(_,appName,"service")**
> **        json(_,thread,"thread")**
> **        json(_,severity,"status")**
> **        json(_,trace,"trace_id")**
> **        json(_,span,"span_id")**
> **        json(_,`@timestamp`,"time")**
> **        default_time(time)**
> **    **
> **    logging-socket-demo.conf: |-**
> **        [[inputs.logging]]**
> **          ## required**
> **        #  logfiles = [**
> **        #    "/var/log/syslog",**
> **        #    "/var/log/message",**
> **        #  ]**
> **          # only two protocols are supported:TCP and UDP**
> **          sockets = [**
> **                 "tcp://0.0.0.0:9541",**
> **          #      "udp://0.0.0.0:9531",**
> **          ]**
> **          ## glob filteer**
> **          ignore = [""]**
> <br />
> **          ## your logging source, if it's empty, use 'default'**
> **          source = "socket_log"**
> <br />
> **          ## add service tag, if it's empty, use $source.**
> **          service = "socket_service"**
> <br />
> **          ## grok pipeline script name**
> **          pipeline = "logback_socket_pipeline.p"**
> <br />
> **          ## optional status:**
> **          ##   "emerg","alert","critical","error","warning","info","debug","OK"**
> **          ignore_status = []**
> <br />
> **          ## optional encodings:**
> **          ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""**
> **          character_encoding = ""**
> <br />
> **          ## The pattern should be a regexp. Note the use of '''this regexp'''**
> **          ## regexp link: **[**https://golang.org/pkg/regexp/syntax/#hdr-Syntax**](https://golang.org/pkg/regexp/syntax/#hdr-Syntax)
> **          # multiline_match = '''^\S'''**
> <br />
> **          ## removes ANSI escape codes from text strings**
> **          remove_ansi_escape_codes = false**
> <br />
> **          [inputs.logging.tags]**
> **            service = "sign"**


### 部署
> kubectl apply -f datakit.yaml

查看部署情况
> [root@master ~]# kubectl get pods -n datakit
> NAME            READY   STATUS    RESTARTS   AGE
> datakit-pf4sp   1/1     Running   0          22h
> datakit-tj9zq   1/1     Running   0          22h


## Springboot应用
基于Springboot应用，操作如下步骤：
### 新增pom依赖
> <dependency><br />   <groupId>net.logstash.logback</groupId><br />   <artifactId>logstash-logback-encoder</artifactId><br />   <version>4.9</version><br /></dependency>

### logback socket 配置
> _<!-- 对日志进行了json序列化处理，dk支持文本格式的日志，可以通过socket直接推送过去--><br />    _<appender _name_="socket" _class_="net.logstash.logback.appender.LogstashTcpSocketAppender"><br />        _<!-- datakit host: logsocket_port --><br />        _<destination>${dkSocketHost}:${dkSocketPort}</destination><br />        _<!-- 日志输出编码 --><br />        _<encoder _class_="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder"><br />            <providers><br />                <timestamp><br />                    <timeZone>UTC+8</timeZone><br />                </timestamp><br />                <pattern><br />                        <pattern><br />                            {<br />                            "severity": "%level",<br />                            "appName": "${logName:-}",<br />                            "trace": "%X{dd.trace_id:-}",<br />                            "span": "%X{dd.span_id:-}",<br />                            "pid": "${PID:-}",<br />                            "thread": "%thread",<br />                            "class": "%logger{40}",<br />                            "msg": "%message\n%exception"<br />                            }<br />                        </pattern><br />                </pattern><br />            </providers><br />        </encoder><br />    </appender>
> 
> <root _level_="info"><br />    <!-- socket appender --><br />    <appender-ref _ref_="socket" /><br /></root>

### logback-spring.xml 全文
> <?_xml version_="1.0" _encoding_="UTF-8"?><br /><configuration _scan_="true" _scanPeriod_="30 seconds"><br />    _<!-- 部分参数需要来源于properties文件 --><br />    _<springProperty _scope_="context" _name_="logName" _source_="spring.application.name" _defaultValue_="localhost.log"/><br />    <springProperty _scope_="context" _name_="dkSocketHost" _source_="datakit.socket.host" /><br />    <springProperty _scope_="context" _name_="dkSocketPort" _source_="datakit.socket.port" /><br />    _<!-- 配置后可以动态修改日志级别--><br />    _<jmxConfigurator /><br />    <property _name_="log.pattern" _value_="%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] %X{dd.service} %X{dd.trace_id} %X{dd.span_id} - %msg%n" />

    _<!-- %m输出的信息,%p日志级别,%t线程名,%d日期,%c类的全名,,,, --><br />    _<appender _name_="STDOUT" _class_="ch.qos.logback.core.ConsoleAppender"><br />        <encoder><br />            <pattern>${log.pattern}</pattern><br />            <charset>UTF-8</charset><br />        </encoder><br />    </appender>

    <appender _name_="FILE" _class_="ch.qos.logback.core.rolling.RollingFileAppender"><br />        <file>logs/${logName}/${logName}.log</file>    _<!-- 使用方法 --><br />        _<append>true</append><br />        <rollingPolicy _class_="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy"><br />            <fileNamePattern>logs/${logName}/${logName}-%d{yyyy-MM-dd}.log.%i</fileNamePattern><br />            <maxFileSize>64MB</maxFileSize><br />            <maxHistory>30</maxHistory><br />            <totalSizeCap>1GB</totalSizeCap><br />        </rollingPolicy>__        _<encoder><br />            <pattern>${log.pattern}</pattern><br />            <charset>UTF-8</charset><br />        </encoder><br />    </appender>

    _<!-- 对日志进行了json序列化处理，dk支持文本格式的日志，可以通过socket直接推送过去--><br />    _<appender _name_="socket" _class_="net.logstash.logback.appender.LogstashTcpSocketAppender"><br />        _<!-- datakit host: logsocket_port --><br />        _<destination>${dkSocketHost}:${dkSocketPort}</destination><br />        _<!-- 日志输出编码 --><br />        _<encoder _class_="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder"><br />            <providers><br />                <timestamp><br />                    <timeZone>UTC+8</timeZone><br />                </timestamp><br />                <pattern><br />                        <pattern><br />                            {<br />                            "severity": "%level",<br />                            "appName": "${logName:-}",<br />                            "trace": "%X{dd.trace_id:-}",<br />                            "span": "%X{dd.span_id:-}",<br />                            "pid": "${PID:-}",<br />                            "thread": "%thread",<br />                            "class": "%logger{40}",<br />                            "msg": "%message\n%exception"<br />                            }<br />                        </pattern><br />                </pattern><br />            </providers><br />        </encoder><br />    </appender>

    _<!-- 只打印error级别的内容 --><br />    _<logger _name_="com.netflix" _level_="ERROR" /><br />    <logger _name_="net.sf.json" _level_="ERROR" /><br />    <logger _name_="org.springframework" _level_="ERROR" /><br />    <logger _name_="springfox" _level_="ERROR" />

    _<!-- sql 打印 配置--><br />    _<logger _name_="com.github.pagehelper.mapper" _level_="DEBUG" /><br />    <logger _name_="org.apache.ibatis" _level_="DEBUG" />

    <root _level_="info"><br />        <appender-ref _ref_="STDOUT" /><br />        <appender-ref _ref_="FILE" /><br />        <appender-ref _ref_="socket" />__    _</root><br /></configuration>

_ps:可以根据实际应用情况进行调整。_
### application.properties
> datakit.socket.host=192.168.11.12
> datakit.socket.port=9542
> server.port=8080
> spring.application.name=socket-demo

### Dockfile
> _FROM _openjdk:8u292<br />_RUN /_bin_/_cp _/_usr_/_share_/_zoneinfo_/_Asia_/_Shanghai _/_etc_/_localtime<br />_RUN _echo 'Asia/Shanghai' _>/_etc_/_timezone

_ENV _jar springboot-logback-socket-appender-demo.jar<br />_ENV _workdir _/_data_/_app_/<br />RUN _mkdir _-_p ${workdir}<br />_COPY _${jar} ${workdir}<br />_WORKDIR _${workdir}

_ENTRYPOINT _["sh", "-ec", "exec java ${JAVA_OPTS}   -jar ${jar} ${PARAMS}  2>&1 > /dev/null"]

### Docker镜像发布
将jar copy 到当前目录<br />打包镜像
> docker build -t registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-logback-socket-appender-demo:v1 .

推送到docker-hub，这里我推送到了阿里云hub仓库。
> docker push registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-logback-socket-appender-demo:v1

### 部署
编写springboot-logback-socket-appender-demo-deployment.yaml文件，需要修改参数：<br />DATAKIT_SOCKET_PORT：datakit 日志socket 端口。<br />dd-java-agent 为datadog的Java-agent，用于trace，如果不需要的话，可以移除相关配置。<br />全文内容如下：
> apiVersion: v1<br />kind: Service<br />metadata:<br />  name: logback-socket-service<br />  labels:<br />    app: logback-socket-service<br />spec:<br />  selector:<br />    app: logback-socket-service<br />  ports:<br />    - protocol: TCP<br />      port: 8080<br />      nodePort: 32100<br />      targetPort: 8080<br />  type: NodePort<br />---<br />apiVersion: apps/v1<br />kind: Deployment<br />metadata:<br />  name: logback-socket-service<br />  labels:<br />    app: logback-socket-service<br />spec:<br />  replicas: 1<br />  selector:<br />    matchLabels:<br />      app: logback-socket-service<br />  template:<br />    metadata:<br />      labels:<br />        app: logback-socket-service<br />    spec:<br />      nodeName: master<br />      containers:      <br />      - env:<br />        - name: POD_NAME<br />          valueFrom:<br />            fieldRef:<br />              fieldPath: metadata.name<br />        - name: DATAKIT_SOCKET_PORT<br />          value: "9541"<br />        - name: JAVA_OPTS<br />          value: |-<br />            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service=demo-k8s-logback-socket  -Ddd.tags=container_host:$(PODE_NAME) -Ddd.service.mapping=mysql:mysql-k8s,redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529<br />        - name: PARAMS<br />          value: "--datakit.socket.host=$(DD_AGENT_HOST) --datakit.socket.port=$(DATAKIT_SOCKET_PORT)"<br />        - name: DD_AGENT_HOST<br />          valueFrom:<br />            fieldRef:<br />              apiVersion: v1<br />              fieldPath: status.hostIP<br />        name: logback-socket-service<br />        image: registry.cn-shenzhen.aliyuncs.com/lr_715377484/springboot-logback-socket-appender-demo:v1<br />        _#command: ["sh","-c"]<br />        _ports:<br />        - containerPort: 8080<br />          protocol: TCP<br />        volumeMounts:<br />        - name: ddagent<br />          mountPath: /usr/dd-java-agent/agent<br />        resources:<br />          limits: <br />            memory: 512Mi<br />          requests:<br />            memory: 256Mi<br />      initContainers:<br />      - command:<br />        - sh<br />        - -c<br />        - set -ex;mkdir -p /ddtrace/agent;cp -r /usr/dd-java-agent/agent/* /ddtrace/agent;<br />        image: pubrepo.jiagouyun.com/datakit/dk-sidecar:1.0<br />        imagePullPolicy: Always<br />        name: ddtrace-agent-sidecar<br />        volumeMounts:<br />        - mountPath: /ddtrace/agent<br />          name: ddagent<br />      restartPolicy: Always<br />      volumes:<br />      - name: ddagent<br />        emptyDir: {}        


发布应用
> kubectl apply -f springboot-logback-socket-appender-demo-deployment.yaml


查看应用状态
> [root@master logback-socket]# kubectl get pods  -l app=logback-socket-service
> NAME                                      READY   STATUS    RESTARTS   AGE
> logback-socket-service-74bd778fcf-cqcn9   1/1     Running   0          5h41m


# 观测云查看日志
日志查看器<br />![image.png](https://cdn.nlark.com/yuque/0/2022/png/22022417/1645512975489-d8c0386b-718f-4b19-9c83-e87c999ce440.png#clientId=ua0e952e8-23cb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=953&id=u683dd1f8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=953&originWidth=1916&originalType=binary&ratio=1&rotation=0&showTitle=false&size=147923&status=done&style=none&taskId=ua36a2b63-3ac1-4827-8e36-ec217e54d6a&title=&width=1916)<br />日志明细<br />![image.png](https://cdn.nlark.com/yuque/0/2022/png/22022417/1645513033820-311e9f9e-8e9d-46ac-afe7-39bd6f8a6661.png#clientId=ua0e952e8-23cb-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=817&id=u243927a8&margin=%5Bobject%20Object%5D&name=image.png&originHeight=817&originWidth=1917&originalType=binary&ratio=1&rotation=0&showTitle=false&size=128947&status=done&style=none&taskId=u3a9a723c-5939-4cab-b358-8f24be29eab&title=&width=1917)
# 相关最佳实践
[**Kubernetes应用的RUM-APM-LOG联动分析**](https://www.yuque.com/dataflux/bp/k8s-rum-apm-log)<br />[观测云日志采集分析最佳实践](https://www.yuque.com/dataflux/bp/logging)<br />[Pod日志采集最佳实践 ](https://www.yuque.com/dataflux/bp/pod-log)<br />[Java日志关联链路数据](https://www.yuque.com/dataflux/doc/yyg3lp)


