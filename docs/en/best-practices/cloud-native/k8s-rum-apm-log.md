# Kubernetes Application RUM-APM-LOG Joint Analysis

---

## Use Case Introduction

The most important source of revenue for enterprises is business, and currently, the majority of businesses are supported by corresponding IT systems. So how to ensure the stability of a company's business boils down to ensuring the stability of internal IT systems within the enterprise. When the business system encounters anomalies or malfunctions, it often requires coordination among colleagues from various aspects such as business, application development, and operations for troubleshooting, which involves **cross-platform, cross-department, and cross-professional domain** issues, making the process **both time-consuming and labor-intensive**.

To address this issue, there are already relatively mature methods in the industry, which involve using **RUM + APM + LOG** to achieve unified monitoring of the entire business system’s **front-end and back-end, logs**, while connecting the three-party data through key fields to enable **joint analysis**, thereby enhancing the efficiency of relevant staff and ensuring smooth system operation.

- APM: Application Performance Monitoring
- RUM: Real User Monitoring
- LOG: Logs

This article will elaborate on how to integrate these three types of monitoring and how to use <<< custom_key.brand_name >>> for joint analysis. The demo used is the RuoYi permission management system. For more details, please refer to <[From 0 to 1 Utilizing <<< custom_key.brand_name >>> to Build Observability for Spring Cloud Services](../monitoring/spring-cloud-sample.md)>.

Regarding logs, this article will use DataKit's Logfwd collector to gather logs from the business Pod. DataKit enables the Logfwd collector, adds lgfwd Sidecar to Pods to collect logs from the business container and send them to DataKit. Since the business is visible to the Sidecar, log files do not need to be stored on the host machine. Please see the [Deploy System](#system) module below for detailed usage. After receiving the logs, DataKit uses the configured Pipeline to parse the log files.

## Prerequisites

### Account Registration

Go to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) to register an account, and log in with your registered account/ password.

![image](../images/k8s-rum-apm-log/1.png)

---

### Deploy DataKit via DaemonSet

#### Obtain OpenWay Address Token

Click 「Manage」 - 「Basic Settings」, copy the token shown in the following image.

![image](../images/k8s-rum-apm-log/2.png)

Click 「Integration」 - 「DataKit」 - 「Kubernetes」 to obtain the latest `datakit.yaml` file.

![image](../images/k8s-rum-apm-log/3.png)

#### Execute Installation

- Follow the steps in the `datakit.yaml` file, replacing `your-token` in the file with the token obtained from the above step.
- Enable the container collector, logfwd collector, and ddtrace collector by mounting `container.conf`, `logfwdserver.conf`, and `ddtrace.conf` files in the DataKit container.

> **Note:** Different versions of DataKit may have different configurations; please follow the latest version. This yaml includes complete deployment configurations and subsequent steps for configuring DataKit.

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
          - <<< custom_key.brand_main_domain >>>
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
              value: https://openway.<<< custom_key.brand_main_domain >>>?token=XXXXXX
            - name: ENV_GLOBAL_HOST_TAGS # Non-election tags
              value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
            - name: ENV_DEFAULT_ENABLED_INPUTS
              value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ebpf,rum
            - name: ENV_ENABLE_ELECTION
              value: enable
            - name: ENV_GLOBAL_ENV_TAGS # Useful only for election tags
              value: cluster_name_k8s=k8s-prod
            - name: ENV_HTTP_LISTEN
              value: 0.0.0.0:9529
            - name: ENV_NAMESPACE # For election
              value: guance-k8s-demo
            #- name: ENV_LOG_LEVEL
            #  value: debug
            #- name: ENV_K8S_CLUSTER_NAME
            #  value: k8s-prod
            image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.4.10
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
          #container_exclude_log = ["image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd*", "image:pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit*"]

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
          ## logfwd receiving end listens on address and port
          address = "0.0.0.0:9531"

          [inputs.logfwdserver.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
    ```

Different Kubernetes clusters require distinguishing DaemonSets deployed DataKit elections by adding the `ENV_NAMESPACE` environment variable, where values under the same token cannot repeat.

Global tags must be added under the same token to distinguish different Kubernetes clusters, with the value being `cluster_name_k8s=k8s-prod`.

> Refer to <[Best Practices for Multiple Kubernetes Cluster Metrics Collection](multi-cluster.md)> for details.

Execute the commands:

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f  datakit.yaml
$ kubectl get pod -n datakit
```

![image](../images/k8s-rum-apm-log/4.png)

After DataKit installation, Linux host common plugins are enabled by default. You can view them in 「<<< custom_key.brand_name >>>」 - 「Scenarios」 - 「Infrastructure Linux Host Monitoring View」.

| Collector Name | Description |
| -------------- | ----------- |
| cpu | Collect CPU usage statistics for the host |
| disk | Collect disk usage statistics |
| diskio | Collect disk IO statistics for the host |
| mem | Collect memory usage statistics for the host |
| swap | Collect Swap memory usage statistics |
| system | Collect operating system load for the host |
| net | Collect network traffic statistics for the host |
| host_process | Collect resident (survived over 10 minutes) processes on the host |
| hostobject | Collect basic information about the host (such as OS info, hardware info, etc.) |
| kubernetes | Collect Kubernetes cluster metrics |
| container | Collect possible container objects and container logs on the host |

Click the 「Infrastructure」 module to view the list of all hosts where DataKit is installed.

![image](../images/k8s-rum-apm-log/5.png)

Click 「Hostname」 to view detailed system information and integration running status (all installed plugins on that host).

![image](../images/k8s-rum-apm-log/6.png)

![image](../images/k8s-rum-apm-log/7.png)

### Deploy Application Example

#### Example Explanation

The Web layer accesses the backend Auth and System services through the gateway. The Web is developed using Vue, while the backend is developed in Java.<br />
In the example, Statsd collects JVM metrics, and the image repository used is `172.16.0.215:5000`. In the example, ddtrace collects JVM metrics for the Java application, and Nacos, Redis, MySQL internal network IP is `172.16.0.230`.

![image](../images/k8s-rum-apm-log/8.png)

#### Write Web Deployment File

Copy the Web application content to `/usr/local/k8s/dist`.

![image](../images/k8s-rum-apm-log/9.png)

Create `/usr/local/k8s/DockerfileWeb`.

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

Create `/usr/local/k8s/nginx.conf`.

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

Create `/usr/local/k8s/web-deployment.yaml`.

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

When starting the user's jar with `java -jar`, you need to use `-javaagent:/usr/local/datakit/data/dd-java-agent.jar`. However, this jar may not exist in the user's image. To avoid modifying the customer's business image, we need to create an image containing `dd-java-agent.jar` and start it as an Init container before the business container, providing `dd-java-agent.jar` via shared storage.

<<< custom_key.brand_name >>> has already provided this image.

```
pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init
```

This example uses the Sidecar method. If you want to directly embed the jar into the image, please download [dd-java-agent](https://github.com/GuanceCloud/dd-trace-java), and refer to the script below in your Dockerfile to embed the jar into the image. In the deployment yaml, change the -javaagent jar to the one you embedded.

```
FROM openjdk:8u292

ENV workdir /data/app/
RUN mkdir -p ${workdir}

COPY  dd-java-agent.jar ${workdir}  # Here is embedding the dd-java-agent into the image
```

#### Write Gateway Deployment File

Create `/usr/local/k8s/DockerfileGateway`.

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

Create `/usr/local/k8s/gateway-deployment.yaml`.

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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init
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

#### Write Auth Deployment File

Create `/usr/local/k8s/DockerfileAuth`.

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

Create `/usr/local/k8s/auth-deployment.yaml`.

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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init
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

#### Write System Deployment File

Create `/usr/local/k8s/DockerfileSystem`.

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

Create `/usr/local/k8s/system-deployment.yaml`, which uses 3 images `172.16.0.238/df-ruoyi/demo-system:v1`, `pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd:1.2.7`, `pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init`. <br />
Among them, dd-lib-java-init provides the `dd-java-agent.jar` file for the system-container business container, and logfwd collects the log files from the business container. The configuration file for logfwd is mounted into the container via ConfigMap, specifying the location of the logs to be collected, source name, etc., in the configuration file.

The complete content of `system-deployment.yaml` is as follows:

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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd:1.2.7
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
            image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init
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

Additionally, `system-deployment.yaml` uses environment variables to specify DataKit and logfwd ports.

Environment Variable Description:

- LOGFWD_DATAKIT_HOST: DataKit address
- LOGFWD_DATAKIT_PORT: logfwd port

logfwd-conf Parameter Description:

- logfiles: List of log files.
- ignore: File path filter, using glob rules, any matching condition will prevent collection of that file.
- source: Data source.
- service: Additional tag if left blank defaults to `$source`.
- pipeline: Script path when using pipeline.
- character_encoding: Choose encoding.
- multiline_match: Multi-line matching.
- remove_ansi_escape_codes: Whether to remove ANSI escape codes, such as text color in standard output, value is true or false.

#### Add node_ip Tag to Trace Data

Add ConfigMap in `datakit.yaml`:

```toml
ddtrace.conf: |-
  [[inputs.ddtrace]]
    endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
    # ignore_resources = []
    customer_tags = ["node_ip"]
```

Add under volumeMounts:

```yaml
- mountPath: /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
  name: datakit-conf
  subPath: ddtrace.conf
```

## User Access Monitoring (RUM)

#### Create Application

Log in to the 「<<< custom_key.brand_name >>> platform」, choose 「User Access Monitoring」 - 「Create Application」 - 「Select Web Type」 - 「Sync Load」, and input the application name web-k8s-demo.

![image](../images/k8s-rum-apm-log/10.png)

#### Enable Frontend RUM Monitoring

Enable the RUM collector in DataKit by adding `rum` to the `ENV_DEFAULT_ENABLED_INPUTS` environment variable value.

```yaml
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container,statsd,ebpf,rum
```

The DataKit address used for user access monitoring needs to be accessible by the customer's network, so modify the DataKit configuration file `/usr/local/datakit/conf.d/datakit.conf` to `listen="0.0.0.0:9529"`. <br />
In this example, DataKit is deployed via DaemonSet, and the default configuration has been modified. It is recommended to deploy a separate DataKit for production RUM usage.

Modify the `/usr/local/k8s/dist/index.html` file, add the following content in the head section:

```
<script src="https://static.<<< custom_key.brand_main_domain >>>/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
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
Parameter Description:

- applicationId: Application id.

- datakitOrigin: The address or domain name of DataKit accessible by users, here 172.16.0.230 is the ip address of k8s node1.

- env: Required, the environment to which the application belongs, either test or product or other fields.

- version: Required, the version number to which the application belongs.

- allowedTracingOrigins: RUM integrated with APM, configure the backend server address or domain name. Since both frontend and backend access addresses in this example are [http://8.1.136.193.105:30000/](http://8.136.193.105:30000/), the port 30000 needs to be included during configuration.

- trackInteractions: User behavior statistics, such as clicking buttons and submitting information.

- traceType: Not mandatory, default is ddtrace. Currently supports 6 types: ddtrace, zipkin, skywalking_v3, jaeger, zipkin_single_header, w3c_traceparent.

> For a detailed understanding of user access monitoring, refer to <[Best Practices for Web Application Monitoring (RUM)](../monitoring/web.md)>.

## Application Performance Monitoring (APM)

#### Enable ddtrace

Refer to <[Add node_ip Tag to Trace Data](#node_ip)>.

#### Java Application Integration with ddtrace

In the `DockerfileSystem` used to create the system image file, the command to start the jar is:

```
exec java ${JAVA_OPTS}   -jar ${jar}
```

The environment variable `JAVA_OPTS` is defined in the deployment file `system-deployment.yaml` as follows:

```
- name: JAVA_OPTS
  value: |-
    -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=demo-k8s-system  -Ddd.tags=container_host:$(POD_NAME) -Ddd.service.mapping=mysql:mysql-k8s,redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529
```

Detailed explanation of JAVA_OPTS:

```
-Ddd.env: The application's environment type, optional.
-Ddd.tags: Custom tags, multiple separated by commas, optional.
-Ddd.service.name: The application name for JVM data source, required.
-Ddd.agent.host=localhost    DataKit address, optional.
-Ddd.agent.port=9529         DataKit port, required.
-Ddd.version: Version, optional.
-Ddd.jmxfetch.check-period Indicates collection frequency in milliseconds, default 1500, optional.
-Ddd.jmxfetch.statsd.host=127.0.0.1 statsd collector connection address same as DataKit address, optional.
-Ddd.jmxfetch.statsd.port=8125 Indicates the UDP connection port of the statsd collector on DataKit, default 8125, optional.
-Ddd.trace.health.metrics.statsd.host=127.0.0.1 Own metric data collection send address same as DataKit address, optional.
-Ddd.trace.health.metrics.statsd.port=8125 Own metric data collection send port, optional.
-Ddd.service.mapping: Alias for redis, mysql applications called, optional.
```

> **Note:** The `JAVA_OPTS` does not specify the DataKit address where the trace data should be reported; instead, it specifies the DataKit address through the environment variable `DD_AGENT_HOST` defined in the yaml file. In Kubernetes clusters, the principle of reporting trace data is that POD trace data is reported to the DataKit deployed on the same host machine. Detailed configurations can be found in `system-deployment.yaml`.

```yaml
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: status.hostIP
```

#### Set Cross-origin Request Whitelist

response.headers.add('Access-Control-Allow-Headers','x-datadog-parent-id,x-datadog-sampled,x-datadog-sampling-priority,x-datadog-trace-id')

## Logs

#### Configure logback.xml

Modify `logback.xml` to output traceId, spanId, and service to logs for association with traces.

![image](../images/k8s-rum-apm-log/11.png)

#### Enable Log Collection

For Kubernetes log collection, it is recommended to use DataKit's logfwd collector,

```toml
    logfwdserver.conf: |-
      [inputs.logfwdserver]
        ## logfwd receiving end listens on address and port
        address = "0.0.0.0:9531"

        [inputs.logfwdserver.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
```

Add under volumeMounts:

```yaml
- mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
  name: datakit-conf
  subPath: logfwdserver.conf
```

#### Log Segmentation Pipeline

Use Pipeline to segment logs generated by the System system, cutting key information into tags, such as traceID, to associate with traces.

Click the 「Logs」 module, enter 「Pipelines*」, create a new Pipeline, select `Source: k8s-log-system` set when collecting logs in the System module, input the following content, test successfully and click 「Save」.

```
#2022-08-09 13:39:57.392 [http-nio-9201-exec-4] INFO  c.r.s.c.SysUserController - [list,70] - demo-k8s-system 1241118275256671447 9052729774571622516 - Start querying user list

grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] - %{DATA:service_name} %{DATA:trace_id} %{DATA:span_id} - %{GREEDYDATA:msg}")

default_time(time,"Asia/Shanghai")
```

![image](../images/k8s-rum-apm-log/22.png)

## Deploy Application

#### Build Image and Upload to Harbor Repository

```shell
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

#### Deployment

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f web-deployment.yaml
$ kubectl apply -f gateway-deployment.yaml
$ kubectl apply -f auth-deployment.yaml
$ kubectl apply -f system-deployment.yaml
```

![image](../images/k8s-rum-apm-log/12.png)

## Trace Analysis

#### RUM APM Linkage

Access the Web application, click 「System Management」 - 「User Management」, at this point trigger the user list query request list, `dataflux-rum.js` will generate a trace-id stored in the header, you can see that the trace-id corresponding to the list interface is 2772508174716324531. After calling the backend list interface, the backend ddtrace reads the trace-id and records it in its own trace data. Adding `%X{dd.trace_id}` in `logback.xml`, the trace_id will be output with the logs, thus achieving **RUM, APM, and Log linkage**.

![image](../images/k8s-rum-apm-log/13.png)

Click 「User Access Monitoring」 - 「ruoyi-k8s-web」 - 「Explorer」 - 「View」, the previous operation was querying the user management list, so click `/system/user` in the list.

![image](../images/k8s-rum-apm-log/14.png)

Click 「Fetch/XHR」

![image](../images/k8s-rum-apm-log/15.png)

Click `prod-api/system/user/list` in the above figure, prod-api is the forwarding request added by nginx, `/system/user/list` is the backend API interface, entering inside you can see specific request and response time details.

![image](../images/k8s-rum-apm-log/16.png)

![image](../images/k8s-rum-apm-log/17.png)

![image](../images/k8s-rum-apm-log/18.png)

#### Log Analysis

Click the 「Logs」 module, choose 「All Sources」, default query logs from the last 15 minutes. According to the frontend-generated `trace_id 2772508174716324531`, fill it in the 「Search Bar」, press Enter to search.

![image](../images/k8s-rum-apm-log/19.png)

Click 「Application Performance Monitoring」 - 「Trace Filter」 - Input `trace_id:704229736283371775`, press Enter to retrieve the trace call situation.

![image](../images/k8s-rum-apm-log/20.png)

Click 「SysUserController.list」 to view detailed information.

![image](../images/k8s-rum-apm-log/21.png)