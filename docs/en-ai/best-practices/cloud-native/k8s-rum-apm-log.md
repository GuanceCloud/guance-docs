# Kubernetes Application RUM-APM-LOG Joint Analysis

---

## Introduction to Application Scenarios

For enterprises, the most important source of revenue is business operations, which are mostly supported by corresponding IT systems. Ensuring the stability of these business operations translates internally into ensuring the stability of the IT systems. When a business system experiences anomalies or failures, it often requires coordination among colleagues from various departments such as business, application development, and operations to diagnose the issue. This process involves **cross-platform, cross-departmental, and cross-domain** challenges, making it both **time-consuming and labor-intensive**.

To address this problem, the industry has developed mature methods, specifically through the integration of **RUM + APM + LOG** to achieve unified monitoring of the entire business system's **front-end, back-end, and logs**. By correlating data from these three sources via key fields, **joint analysis** can be performed to enhance work efficiency and ensure system stability.

- APM: Application Performance Monitoring
- RUM: Real User Monitoring
- LOG: Logs

This article will explain how to integrate these three monitoring tools and how to use Guance for joint analysis. The demo application used here is the RuoYi permission management system. For more details, refer to <[Building Observability for Spring Cloud Services with Guance](../monitoring/spring-cloud-sample.md)>.

Regarding logs, this article will use DataKit’s Logfwd collector to gather logs from business Pods. DataKit will enable the Logfwd collector, and Pods will add a Sidecar container to collect logs from the business containers and send them to DataKit. Since the business containers are visible to the Sidecar, log files do not need to be written to the host machine. Detailed usage can be found in the [Deployment System](#system) section below. After receiving the logs, DataKit will use the configured Pipeline to parse the log files.

## Prerequisites

### Account Registration

Go to [Guance](https://console.guance.com/) to register an account and log in using your registered credentials.

![image](../images/k8s-rum-apm-log/1.png)

---

### Deploying DataKit via DaemonSet

#### Obtain the OpenWay Address Token

Click on 「Management」 - 「Basic Settings」 and copy the token shown in the image below.

![image](../images/k8s-rum-apm-log/2.png)

Click on 「Integration」 - 「DataKit」 - 「Kubernetes」 to get the latest `datakit.yaml` file.

![image](../images/k8s-rum-apm-log/3.png)

#### Execute Installation

- Follow the steps in the obtained `datakit.yaml` file and replace `your-token` with the copied token.
- Enable the container collector, logfwd collector, and ddtrace collector by mounting the `container.conf`, `logfwdserver.conf`, and `ddtrace.conf` files within the DataKit container.

> **Note:** Configuration may vary depending on the DataKit version. Please refer to the latest version. This YAML contains the complete configuration for this deployment, including subsequent steps for configuring DataKit.

??? quote "Complete YAML Content"

    ```yaml
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
          - guance.com
        resources:
          - datakits
        verbs:
          - get
          - list
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
            - name: ENV_K8S_NODE_NAME
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: spec.nodeName
            - name: ENV_DATAWAY
              value: https://openway.guance.com?token=XXXXXX
            - name: ENV_GLOBAL_HOST_TAGS # Non-election tags
              value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
            - name: ENV_DEFAULT_ENABLED_INPUTS
              value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ebpf,rum
            - name: ENV_ENABLE_ELECTION
              value: enable
            - name: ENV_GLOBAL_ENV_TAGS # Only useful for election tags
              value: cluster_name_k8s=k8s-prod
            - name: ENV_HTTP_LISTEN
              value: 0.0.0.0:9529
            - name: ENV_NAMESPACE # For election
              value: guance-k8s-demo
            #- name: ENV_LOG_LEVEL
            #  value: debug
            #- name: ENV_K8S_CLUSTER_NAME
            #  value: k8s-prod
            image: pubrepo.jiagouyun.com/datakit/datakit:1.4.10
            imagePullPolicy: Always
            name: datakit
            ports:
            - containerPort: 9529
              hostPort: 9529
              name: port
              protocol: TCP
            securityContext:
              privileged: true
            volumeMounts:
            - mountPath: /var/run
              name: run
            - mountPath: /var/lib
              name: lib
            - mountPath: /var/log
              name: log
            #- mountPath: /var/run/containerd/containerd.sock
            #  name: containerd-socket
            #  readOnly: true
            - mountPath: /usr/local/datakit/conf.d/container/container.conf
              name: datakit-conf
              subPath: container.conf
            - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
              name: datakit-conf
              subPath: logfwdserver.conf
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
          tolerations:
            - operator: Exists
          volumes:
            - configMap:
                name: datakit-conf
              name: datakit-conf
            - hostPath:
                path: /var/run
              name: run
            - hostPath:
                path: /var/lib
              name: lib
            - hostPath:
                path: /var/log
              name: log

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
          docker_endpoint = "unix:///var/run/docker.sock"
          containerd_address = "/var/run/containerd/containerd.sock"

          enable_container_metric = true
          enable_k8s_metric = true
          enable_pod_metric = true

          ## Containers logs to include and exclude, default collect all containers. Globs accepted.
          container_include_log = []
          container_exclude_log = ["image:*"]
          #container_exclude_log = ["image:pubrepo.jiagouyun.com/datakit/logfwd*", "image:pubrepo.jiagouyun.com/datakit/datakit*"]

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
          [inputs.ddtrace.close_resource]
            "*" = ["PUT /nacos/*","GET /nacos/*","POST /nacos/*"]
          ## tags is ddtrace configed key value pairs
          # [inputs.ddtrace.tags]
            # some_tag = "some_value"
            # more_tag = "some_other_value"

      #### logfwdserver
      logfwdserver.conf: |-
        [inputs.logfwdserver]
          ## logfwd receiver listening address and port
          address = "0.0.0.0:9531"

          [inputs.logfwdserver.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
    ```

Different Kubernetes clusters require distinguishing between DataKit instances deployed via DaemonSet by adding the `ENV_NAMESPACE` environment variable, with unique values under the same token.

Under the same token, to distinguish between different Kubernetes clusters, add a global tag with the value `cluster_name_k8s=k8s-prod`.

> Refer to <[Best Practices for Collecting Metrics from Multiple Kubernetes Clusters](multi-cluster.md)> for more details.

Execute the commands:

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f  datakit.yaml
$ kubectl get pod -n datakit
```

![image](../images/k8s-rum-apm-log/4.png)

After DataKit is installed, it automatically enables common Linux host plugins. You can view them in 「Guance」 - 「Scenes」 - 「Linux Host Monitoring View」.

| Collector Name | Description                                             |
| -------------- | ------------------------------------------------------- |
| cpu            | Collect CPU usage statistics                            |
| disk           | Collect disk usage                                      |
| diskio         | Collect disk I/O performance                            |
| mem            | Collect memory usage                                    |
| swap           | Collect swap memory usage                               |
| system         | Collect operating system load                           |
| net            | Collect network traffic                                 |
| host_process   | Collect resident (surviving more than 10 minutes) processes |
| hostobject     | Collect basic host information (e.g., OS, hardware info) |
| kubernetes     | Collect Kubernetes cluster metrics                      |
| container      | Collect possible container objects and container logs   |

Click on the 「Infrastructure」 module to view a list of all hosts with installed DataKit instances.

![image](../images/k8s-rum-apm-log/5.png)

Click on 「Hostname」 to view detailed system information and integrated operational status (all installed plugins on that host).

![image](../images/k8s-rum-apm-log/6.png)

![image](../images/k8s-rum-apm-log/7.png)

### Deploying Sample Applications

#### Sample Explanation

The Web layer accesses the backend Auth and System services through a gateway. The Web front-end is developed with Vue, while the backend is developed with Java.<br />
In this sample, Statsd collects JVM metrics, and the image repository used is `172.16.0.215:5000`. The sample uses ddtrace to collect JVM metrics from Java applications, and the internal IP addresses for Nacos, Redis, and MySQL are `172.16.0.230`.

![image](../images/k8s-rum-apm-log/8.png)

#### Writing the Web Deployment File

Copy the content of the Web application to the `/usr/local/k8s/dist` directory.

![image](../images/k8s-rum-apm-log/9.png)

Create the `/usr/local/k8s/DockerfileWeb` file.

```shell
$ vim /usr/local/k8s/DockerfileWeb
```

Content as follows:

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

Create `/usr/local/k8s/nginx.conf`, with the following content:

??? quote "`/usr/local/k8s/nginx.conf`"

    ```toml
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

Create `/usr/local/k8s/web-deployment.yaml`, with the following content:

??? quote "`/usr/local/k8s/web-deployment.yaml`"

    ```yaml
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
            - name: POD_NAME
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

#### dd-java-agent Image

When starting a user's jar with `java -jar`, you need to use `-javaagent:/usr/local/datakit/data/dd-java-agent.jar`. However, this jar may not exist in the user's image. To avoid modifying the customer's business image, we create an image containing `dd-java-agent.jar` and start it as an Init container before the business container, sharing storage to provide `dd-java-agent.jar`.

Guance provides this image.

```
pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
```

In this example, the Sidecar method is used. If you want to directly embed the jar into the image, download [dd-java-agent](https://github.com/GuanceCloud/dd-trace-java), and reference the script below in your Dockerfile to embed the jar into the image. In the deployment yaml, change the `-javaagent` jar path to the one you embedded.

```
FROM openjdk:8u292

ENV workdir /data/app/
RUN mkdir -p ${workdir}

COPY  dd-java-agent.jar ${workdir}  # Embed dd-java-agent into the image
```

#### Writing the Gateway Deployment File

Create `/usr/local/k8s/DockerfileGateway`

```bash
$ vim /usr/local/k8s/DockerfileGateway
```

File content as follows:

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

Create `/usr/local/k8s/gateway-deployment.yaml`, with the following content:

??? quote "`/usr/local/k8s/gateway-deployment.yaml`"

    ```yaml
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
                -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=demo-k8s-gateway  -Ddd.tags=container_host:$(POD_NAME),node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529
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
            - set -ex;mkdir -p /ddtrace/agent;cp -r /datadog-init/* /ddtrace/agent;
            image: pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
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

#### Writing the Auth Deployment File

Create `/usr/local/k8s/DockerfileAuth`

```shell
$ vim  /usr/local/k8s/DockerfileAuth
```

File content as follows:

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

Create `/usr/local/k8s/auth-deployment.yaml`, with the following content:

??? quote "`/usr/local/k8s/auth-deployment.yaml`"

    ```yaml
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
                -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=demo-k8s-auth  -Ddd.tags=container_host:$(POD_NAME),node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529 
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
            - set -ex;mkdir -p /ddtrace/agent;cp -r /datadog-init/* /ddtrace/agent;
            image: pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
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

#### Writing the System Deployment File

Create `/usr/local/k8s/DockerfileSystem`

```shell
$ vim /usr/local/k8s/DockerfileSystem
```

File content as follows:

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

Create `/usr/local/k8s/system-deployment.yaml`, using three images `172.16.0.238/df-ruoyi/demo-system:v1`, `pubrepo.jiagouyun.com/datakit/logfwd:1.2.7`, and `pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init`. <br />
Among these, `dd-lib-java-init` provides the `dd-java-agent.jar` file for the system-container business container, and `logfwd` collects logs from the business container. The configuration file for `logfwd` is mounted into the container via a ConfigMap, specifying the locations of the logs to be collected, the source name, etc.

Complete content of `system-deployment.yaml`:

??? quote "`system-deployment.yaml`"

    ```yaml
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
                -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=demo-k8s-system  -Ddd.tags=container_host:$(POD_NAME),node_ip:$(DD_AGENT_HOST) -Ddd.service.mapping=mysql:mysql-k8s,redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529 
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
            - set -ex;mkdir -p /ddtrace/agent;cp -r /datadog-init/* /ddtrace/agent;
            image: pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
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
                        "multiline_match": "^\\d{4}-\\d{2}-\\d{2}"
                    }
                ]
            }
        ] 
    ```

Additionally, the `system-deployment.yaml` file uses environment variables to specify the DataKit and logfwd port.

Environment Variable Explanations:

- LOGFWD_DATAKIT_HOST: DataKit address
- LOGFWD_DATAKIT_PORT: Logfwd port

Logfwd-conf Parameter Explanations:

- logfiles: List of log files.
- ignore: File path filter using glob rules; files matching any condition will not be collected.
- source: Data source.
- service: Additional tag, defaults to `$source` if empty.
- pipeline: Script path when using a pipeline.
- character_encoding: Encoding selection.
- multiline_match: Multiline matching.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes, e.g., text colors in standard output. Values can be `true` or `false`.

#### Adding node_ip Tags to Trace Data

Add a ConfigMap in `datakit.yaml`:

```toml
ddtrace.conf: |-
  [[inputs.ddtrace]]
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    # ignore_resources = []
    customer_tags = ["node_ip"]
```

Add under `volumeMounts`:

```yaml
- mountPath: /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
  name: datakit-conf
  subPath: ddtrace.conf
```

## User Access Monitoring (RUM)

#### Creating a New Application

Log in to the 「Guance Platform」, select 「User Access Monitoring」 - 「New Application」 - 「Web Type」 - 「Sync Load」, and enter the application name `web-k8s-demo`.

![image](../images/k8s-rum-apm-log/10.png)

#### Enabling Frontend RUM Monitoring

Enable the RUM collector in DataKit by adding `rum` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value.

```yaml
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ebpf,rum
```

The DataKit address used by User Access Monitoring should be accessible from the customer's network. Modify the DataKit configuration file `/usr/local/datakit/conf.d/datakit.conf` to `listen="0.0.0.0:9529"`. <br />
In this example, the DataKit is deployed via DaemonSet and the default configuration has already been modified. In production, it is recommended to deploy a separate DataKit instance for RUM.

Modify the `/usr/local/k8s/dist/index.html` file and add the following content to the `<head>` section:

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

Parameter Explanations:

- applicationId: Application ID.
- datakitOrigin: The address or domain name of the DataKit accessible by users, where `172.16.0.230` is the IP address of node1 in the k8s cluster.
- env: Required, application environment, either `test` or `production` or other.
- version: Required, application version number.
- allowedTracingOrigins: To link RUM with APM, configure the backend server addresses or domains. Since both frontend and backend access addresses in this example are `[http://8.136.193.105:30000/](http://8.136.193.105: