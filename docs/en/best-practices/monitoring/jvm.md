# Best Practices for JVM Observability

---

## Prerequisites
Visit the official website [<<< custom_key.brand_name >>>](https://guance.com/) to register an account, and log in using your registered account credentials.
## Installing DataKit

### Obtain Installation Command

Click on the [**Integration**] module, then [**DataKit**], and choose the appropriate installation command based on your operating system and type.

![](../images/jvm-1.png)

### Execute Installation

Copy the DataKit installation command and run it directly on the server you wish to monitor.

- Installation directory: `/usr/local/datakit/`
- Log directory: `/var/log/datakit/`
- Main configuration file: `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory: `/usr/local/datakit/conf.d/`

### Default Installed Plugins

After DataKit is installed, default plugins for common Linux host metrics are enabled. You can view these under Workspace → Infrastructure by navigating into a host's basic information.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk I/O usage of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects operating system load of the host |
| net | Collects network traffic of the host |
| host_process | Collects long-running (more than 10 minutes) process list on the host |
| hostobject | Collects basic information about the host (e.g., OS info, hardware info) |
| docker | Collects container objects and logs on the host |

### Built-in Views

Click on the [**Infrastructure**] module to view all hosts with installed DataKit and their basic information, such as hostname, CPU, memory, etc.

![image.png](../images/jvm-2.png)

## JVM Collection Configuration:
### JAVA_OPTS Declaration
This example uses ddtrace to collect JVM metrics from Java applications. Define JAVA_OPTS according to your needs and replace JAVA_OPTS when starting the application. The jar start method is as follows:

```java
java  ${JAVA_OPTS} -jar your-app.jar
```

Complete JAVA_OPTS:

```java
-javaagent:/usr/local/datakit/data/dd-java-agent.jar \
 -XX:FlightRecorderOptions=stackdepth=256 \
 -Ddd.profiling.enabled=true  \
 -Ddd.logs.injection=true   \
 -Ddd.trace.sample.rate=1   \
 -Ddd.service.name=your-app-name   \
 -Ddd.env=dev  \ 
 -Ddd.agent.port=9529   \
 -Ddd.jmxfetch.enabled=true   \
 -Ddd.jmxfetch.check-period=1000   \
 -Ddd.jmxfetch.statsd.port=8125   \
 -Ddd.trace.health.metrics.enabled=true   \
 -Ddd.trace.health.metrics.statsd.port=8125   
```

Detailed explanation:

```
-Ddd.env: Application environment type, optional  
-Ddd.tags: Custom tags, optional    
-Ddd.service.name: Application name for JVM data source, required  
-Ddd.agent.host=localhost    DataKit address, optional  
-Ddd.agent.port=9529         DataKit port, required  
-Ddd.version: Version, optional 
-Ddd.jmxfetch.check-period Specifies collection frequency in milliseconds, default 1500, optional   
-Ddd.jmxfetch.statsd.host=127.0.0.1 statsd collector connection address same as DataKit address, optional  
-Ddd.jmxfetch.statsd.port=8125 Indicates UDP connection port for statsd collector on DataKit, default 8125, optional   
-Ddd.trace.health.metrics.statsd.host=127.0.0.1 Self-metric data collection send address same as DataKit address, optional 
-Ddd.trace.health.metrics.statsd.port=8125 Self-metric data collection send port, optional   
-Ddd.service.mapping: Aliases for services like redis, mysql used by the application, optional 
```
For more details on JVM, refer to the [JVM](../../integrations/jvm.md) collector documentation.
### 1. Jar Usage Method

Enable statsd

```shell
$ cd /usr/local/datakit/conf.d/statsd
$ cp statsd.conf.sample statsd.conf
```

Enable ddtrace

```shell
$ cd /usr/local/datakit/conf.d/ddtrace
$ cp ddtrace.conf.sample  ddtrace.conf
```

Restart DataKit

```shell
$ datakit --restart
```

Start the jar, replacing `your-app` with your application name. If your application does not connect to MySQL, remove `-Ddd.service.mapping=mysql:mysql01`, where `mysql01` is the alias for MySQL seen in APM monitoring.

```shell
nohup java -Dfile.encoding=utf-8  \
 -javaagent:/usr/local/datakit/data/dd-java-agent.jar \
 -Ddd.service.name=your-app   \
 -Ddd.service.mapping=mysql:mysql01   \
 -Ddd.env=dev  \
 -Ddd.agent.port=9529   \
 -jar your-app.jar > logs/your-app.log  2>&1 & 
```

### 2. Docker Usage Method

Follow the jar usage method to enable statsd and ddtrace

Open external network access ports

Edit the `/usr/local/datakit/conf.d/vim datakit.conf` file and change `listen = "0.0.0.0:9529"`

![image.png](../images/jvm-3.png)

Restart DataKit

```shell
$ datakit --restart
```

Use environment variables JAVA_OPTS in the ENTRYPOINT of your Dockerfile, as shown below:

```bash
FROM openjdk:8u292-jdk

ENV jar your-app.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}

ENTRYPOINT ["sh", "-ec", "exec java  ${JAVA_OPTS} -jar ${jar} "]
```

Build the image

Save the above content to `/usr/local/java/Dockerfile`

```shell
$ cd /usr/local/java
$ docker build -t your-app-image:v1 .
```

Copy `/usr/local/datakit/data/dd-java-agent.jar` to `/tmp/work` directory

**Docker run start**, modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application's port, and replace `your-app` with your application name, and replace `your-app-image:v1` with your image name

```shell
docker run  -v /tmp/work:/tmp/work -e JAVA_OPTS="-javaagent:/tmp/work/dd-java-agent.jar -Ddd.service.name=your-app  -Ddd.service.mapping=mysql:mysql01 -Ddd.env=dev  -Ddd.agent.host=172.16.0.215 -Ddd.agent.port=9529  -Ddd.jmxfetch.statsd.host=172.16.0.215  " --name your-app -d -p 9299:9299 your-app-image:v1
```

**Docker compose start**

The Dockerfile should declare ARG parameters to receive parameters passed from docker-compose, as shown below:

```bash
FROM openjdk:8u292-jdk

ARG JAVA_ARG
ENV JAVA_OPTS=$JAVA_ARG
ENV jar your-app.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}

ENTRYPOINT ["sh", "-ec", "exec java  ${JAVA_OPTS} -jar ${jar} "]
```

Save the above content to `/usr/local/java/DockerfileTest` and create a `docker-compose.yml` file in the same directory. Modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application's port, replace `your-app` with your application name, and replace `your-app-image:v1` with your image name. An example `docker-compose.yml` is as follows:

```bash
version: "3.9"
services:
  ruoyi-gateway:
    image: your-app-image:v1
    container_name: your-app
    volumes:
      - /tmp/work:/tmp/work
    build:
      dockerfile: DockerfileTest
      context: .
      args:
        - JAVA_ARG=-javaagent:/tmp/work/dd-java-agent.jar  -Ddd.service.name=your-app  -Ddd.service.mapping=mysql:mysql01 -Ddd.env=dev  -Ddd.agent.host=172.16.0.215 -Ddd.agent.port=9529  -Ddd.jmxfetch.statsd.host=172.16.0.215  
    ports:
      
    networks:
      - myNet
networks:
  myNet:
    driver: bridge
```

Start

```shell
$ cd /usr/local/java
# Build the image
$ docker build -t your-app-image:v1 .
# Start
$ docker-compose up -d
```

### 3 Kubernetes Usage Method

#### 3.1 Deploying DataKit

Deploy DataKit using DaemonSet in Kubernetes. Refer to <[Datakit DaemonSet Installation](../../datakit/datakit-daemonset-deploy.md)> 

To collect JVM metrics, enable ddtrace and statsd collectors. For DataKit deployed via DaemonSet, add `statsd, ddtrace` to the ENV_DEFAULT_ENABLED_INPUTS environment variable in the YAML file.

```yaml
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,kubernetes,container,statsd,ddtrace
        
```

The deployment file for this example is `/usr/local/k8s/datakit-default.yaml`, with the following content:

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
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,kubernetes,container,statsd,ddtrace
        - name: ENV_ENABLE_ELECTION
          value: enable
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_LOG_LEVEL
          value: info
        image: pubrepo.jiagouyun.com/datakit/datakit:1.2.1
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
        docker_endpoint = "unix:///var/run/docker.sock"
        containerd_address = "/var/run/containerd/containerd.sock"

        enable_container_metric = true
        enable_k8s_metric = true
        enable_pod_metric = false
        extract_k8s_label_as_tags = false

        ## Auto-Discovery of PrometheusMonitoring Annotations/CRDs
        enable_auto_discovery_of_prometheus_pod_annotations = false
        enable_auto_discovery_of_prometheus_service_annotations = false
        enable_auto_discovery_of_prometheus_pod_monitors = false
        enable_auto_discovery_of_prometheus_service_monitors = false

        ## Containers logs to include and exclude, default collect all containers. Globs accepted.
        container_include_log = []
        container_exclude_log = ["image:*logfwd*", "image:*datakit*"]

        exclude_pause_container = true

        ## Removes ANSI escape codes from text strings
        logging_remove_ansi_escape_codes = false
        ## Search logging interval, default "60s"
        #logging_search_interval = ""

        ## If the data sent failure, will retry forevery
        logging_blocking_mode = true

        kubernetes_url = "https://kubernetes.default:443"

        ## Authorization level:
        ##   bearer_token -> bearer_token_string -> TLS
        ## Use bearer token for authorization. ('bearer_token' takes priority)
        ## linux at:   /run/secrets/kubernetes.io/serviceaccount/token
        ## windows at: C:\var\run\secrets\kubernetes.io\serviceaccount\token
        bearer_token = "/run/secrets/kubernetes.io/serviceaccount/token"
        # bearer_token_string = "<your-token-string>"

        logging_auto_multiline_detection = true
        logging_auto_multiline_extra_patterns = []

        ## Set true to enable election for k8s metric collection
        election = true

        [inputs.container.logging_extra_source_map]
        # source_regexp = "new_source"

        [inputs.container.logging_source_multiline_map]
        # source = '''^\d{4}'''

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
          #pipeline = ""

          ## optional status:
          ##   "emerg","alert","critical","error","warning","info","debug","OK"
          ignore_status = []

          ## optional encodings:
          ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
          character_encoding = ""

          ## The pattern should be a regexp. Note the use of '''this regexp'''
          ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
          match = '''^\d{4}-\d{2}-\d{2}'''

          [inputs.logging.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
          
```

Find the openway address on [https://console.guance.com/](https://console.guance.com/) as shown below, and replace the value of ENV_DATAWAY in `datakit-default.yaml`

![1631933361(1).png](../images/jvm-5.png)

Deploy Datakit

```shell
$ cd /usr/local/k8s
$ kubectl apply -f datakit-default.yaml
$ kubectl get pod -n datakit
```

![image.png](../images/jvm-4.png)

If collecting system logs, refer to the following content:

```yaml
#- mountPath: /usr/local/datakit/conf.d/log/demo-system.conf
#  name: datakit-conf
#  subPath: demo-system.conf
```

```yaml
    #### kubernetes
    demo-system.conf: |-
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
          pipeline = ""

          ## optional status:
          ##   "emerg","alert","critical","error","warning","info","debug","OK"
          ignore_status = []

          ## optional encodings:
          ##    "utf-8", "utf-16le", "utf-16le", "gbk", "gb18030" or ""
          character_encoding = ""

          ## The pattern should be a regexp. Note the use of '''this regexp'''
          ## regexp link: https://golang.org/pkg/regexp/syntax/#hdr-Syntax
          match = '''^\S'''

          [inputs.logging.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
```

#### 3.2 Sidecar Image

In the jar usage method, `dd-java-agent.jar` is used, which may not exist in the user's image. To avoid intruding on the customer's business image, we need to create an image containing `dd-java-agent.jar` and start it as a sidecar before the business container, sharing storage to provide `dd-java-agent.jar`.

```
pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
```

#### 3.3 Writing the Dockerfile for Java Applications
Use environment variables JAVA_OPTS in the ENTRYPOINT of your Dockerfile, as shown below:

```bash
FROM openjdk:8u292

ENV jar your-app.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar}"]
```

Build the image and upload it to the harbor repository, replacing `172.16.0.215:5000/dk` with your image repository.

```shell
$ cd /usr/local/k8s/agent
$ docker build -t 172.16.0.215:5000/dk/your-app-image:v1 . 
$ docker push 172.16.0.215:5000/dk/your-app-image:v1  
```

#### 3.4 Writing Deployment

Create a new file `/usr/local/k8s/your-app-deployment-yaml` with the following content:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: your-app-name
  labels:
    app: your-app-name
spec:
  selector:
    app: your-app-name
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
  name: your-app-name
  labels:
    app: your-app-name
spec:
  replicas: 1
  selector:
    matchLabels:
      app: your-app-name
  template:
    metadata:
      labels:
        app: your-app-name
    spec:
      containers:
      - env:
        - name: PODE_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=<your-app-name> -Ddd.tags=container_host:$(PODE_NAME)  -Ddd.env=dev  -Ddd.agent.port=9529   
        - name: DD_AGENT_HOST
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        name: your-app-name
        image: 172.16.0.215:5000/dk/your-app-image:v1    
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

Explanation: In JAVA_OPTS, `-Ddd.tags=container_host:$(PODE_NAME)` passes the value of the environment variable PODE_NAME to the tag container_host. Replace `9299` with your application's port, `your-app-name` with your service name, `30001` with your application's exposed port, and `172.16.0.215:5000/dk/your-app-image:v1` with your image name.

![image.png](../images/jvm-6.png)

Start

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f your-app-deployment-yaml
```

### Creating a New JVM Observability Scenario:

Log in to [<<< custom_key.brand_name >>>](https://guance.com/), enter the workspace, and click [Create Scenario]

![1631933819(1).png](../images/jvm-7.png)

Click [JVM Monitoring Scenario]

![1631933680(1).png](../images/jvm-8.png)

Enter the scenario name [JVM Monitoring Scenario] and click OK

![1631933860(1).png](../images/jvm-9.png)

Find the JVM monitoring view in the image, hover over it, and click Create

The JVM monitoring view is as follows:

![image.png](../images/jvm-10.png)


## Introduction to JVM and Related Metrics
### 1 Overview of JVM
#### 1.1 What is JVM
JVM stands for Java Virtual Machine, a virtual computer that runs on top of the operating system to execute Java bytecode.
#### 1.2 Class Loading Mechanism
Java source files are first compiled into bytecode by the Java compiler, then loaded by the class loader in the JVM, and finally executed by the JVM execution engine.
#### 1.3 Class Lifecycle
A Java class goes through seven stages from start to finish: Loading, Verification, Preparation, Resolution, Initialization, Using, and Unloading. Among these, Verification, Preparation, and Resolution are collectively known as Linking.

![image.png](../images/jvm-11.png)

#### 1.4 JVM Memory Structure
Throughout the class loading process, the JVM uses a segment of space to store data and related information, commonly referred to as JVM memory. According to the JVM specification, JVM memory is divided into:

- Execution Engine

Java is a cross-platform programming language. The execution engine translates bytecode into machine instructions recognizable by the platform.

- Program Counter

The program counter is a small block of memory that acts as an indicator of the current line number of the bytecode being executed by the thread. In the virtual machine model, the byte code interpreter works by changing the value of this counter to select the next byte code instruction to execute. Branching, looping, jumping, exception handling, thread resumption, and other fundamental features depend on this counter to function correctly.

Characteristics: Occupies very little memory, negligible; thread-isolated; when executing native methods, the program counter value is null; this memory region is the only one in the Java Virtual Machine specification that does not specify any OutOfMemoryError conditions.

- Virtual Machine Stack

Describes the memory model for executing Java methods. Each method creates a "stack frame (Stack Frame)" upon execution, which is thread-private and has a lifecycle consistent with the thread. A stack frame's structure is divided into local variable table, operand stack, dynamic linking, method exit, etc.

What we commonly refer to as "heap memory" and "stack memory" refers to the virtual machine stack, specifically the local variable table within the stack frame because it stores all local variables of a method. When a method is called, a stack frame is created and pushed onto the virtual machine stack; when the method completes execution, the stack frame is popped and destroyed.

The JVM allocates a certain amount of memory for each thread's virtual machine stack (-Xss parameter). If a single thread requests a stack depth greater than what the virtual machine allows, a StackOverflowError (stack overflow error) is thrown. When the entire virtual machine stack memory is exhausted and cannot allocate new memory, an OutOfMemoryError exception is thrown.

- Native Method Stack

The native method stack functions similarly to the virtual machine stack, both having thread isolation characteristics and capable of throwing StackOverflowError and OutOfMemoryError exceptions.

However, the native method stack serves native methods executed by the JVM, while the virtual machine stack serves Java methods executed by the JVM. How does it serve native methods? What language are native methods implemented in? How are structures like stack frames organized to serve methods? The JVM specification does not enforce specific rules, allowing different implementations. The commonly used HotSpot JVM merges the virtual machine stack and the native method stack.

- Method Area

JDK8 deprecated the permanent generation, moving each class's runtime constant pool and compiled code to another local memory area disconnected from the heap—Metaspace.

Metaspace (Metaspace): Metaspace is the implementation of the method area in the HotSpot JVM. The method area mainly stores class information, constant pools, method data, method code, symbolic references, etc. Metaspace essentially resembles the permanent generation, both implementing the method area defined in the JVM specification. However, the biggest difference between Metaspace and the permanent generation is that Metaspace is not part of the virtual machine but uses native memory. Theoretically, it depends on the size of the 32-bit/64-bit system memory and can be configured with -XX:MetaspaceSize and -XX:MaxMetaspaceSize.

Metaspace has two parameters: MetaspaceSize: Initial Metaspace size, controlling GC threshold. MaxMetaspaceSize: Limits Metaspace upper bound, preventing excessive physical memory consumption.

- Heap

Heap is shared by all threads, primarily storing object instances and arrays. It can be located in physically discontinuous spaces but must be logically continuous.

Heap memory is divided into Young Generation, Old Generation. The Young Generation is further divided into Eden and Survivor areas. Survivor consists of FromSpace and ToSpace. Eden occupies most of the capacity, while Survivor two areas occupy less capacity, with a default ratio of 8:1:1.

If there is insufficient memory in the Java heap to complete instance allocation and the heap cannot expand further, the Java virtual machine throws an OutOfMemoryError exception.

Common JVM heap memory parameters:

| **Parameter** | **Description** |
| --- | --- |
| -Xms | Initial heap size, units m, g |
| -Xmx（MaxHeapSize） | Maximum allowed heap size, generally not exceeding 80% of physical memory |
| -XX:PermSize | Initial non-heap memory size, typically setting initialization to 200m, maximum 1024m |
| -XX:MaxPermSize | Maximum allowed non-heap memory size |
| -XX:NewSize（-Xns） | Initial young generation memory size |
| -XX:MaxNewSize（-Xmn） | Maximum allowed young generation memory size, can also be abbreviated |
| -XX:SurvivorRatio=8 | Ratio of Eden to Survivor areas in the young generation, default 8, i.e., 8:1 |
| -Xss | Stack memory size |

- Runtime Data Areas

During the execution of Java programs, the Java virtual machine divides the managed memory into several different data regions. These regions have various purposes and creation/destruction times. Some regions exist as long as the virtual machine process is running, while others depend on the start and end of user threads.

According to the "Java Virtual Machine Specification (Java SE 8 Edition)", the runtime data areas managed by the Java virtual machine include: Program Counter, Java Virtual Machine Stack, Native Method Stack, Java Heap, Method Area.

![image.png](../images/jvm-12.png)

- Direct Memory

Direct memory is not part of the runtime data areas of the virtual machine and is not defined as a memory region in the Java Virtual Machine specification. It is not limited by the size of the Java heap but is constrained by the total available memory of the host.

Direct memory can be specified with -XX:MaxDirectMemorySize. Allocating direct memory consumes higher performance, but direct memory IO read/write performance is better than ordinary heap memory. Exhausting direct memory throws an OutOfMemoryError exception.

- Garbage Collection

Program Counter, Virtual Machine Stack, Native Method Stack are thread-private and follow the thread lifecycle. Stack frames enter and exit the stack orderly as methods are entered and exited. However, the Java Heap and Method Area differ. Different implementations of an interface may require different amounts of memory, and different branches of a method may also require different amounts of memory. We only know which objects will be created during runtime. This part of the memory allocation and reclamation are dynamic, and garbage collectors focus on this part of the memory.

Garbage collectors:

Serial Collector (Serial)

Parallel Collector (Parallel)

CMS Collector (Concurrent Mark Sweep)

G1 Collector (Garbage First)

Garbage collection algorithms (GC, Garbage Collection):

Mark-Sweep (Mark-Sweep)

Copying (Copy)

Mark-Compact (Mark-Compact)
#### 1.5 GC, Full GC
To support generational garbage collection, Java heap memory is divided into three generations: Young Generation, Old Generation, and Permanent Generation. Whether the permanent generation executes GC depends on the JVM used. Newly generated objects are preferentially placed in the Young Generation Eden area, large objects directly enter the Old Generation, and when the Eden area lacks sufficient space, a Minor GC is triggered. Surviving objects move to the Survivor0 area, and when Survivor0 is full, another Minor GC is triggered, moving surviving objects to Survivor1. This ensures that one survivor area remains empty for some time. After multiple Minor GCs (default 15 times), surviving objects move to the Old Generation. The Old Generation stores long-lived objects, and when promoted objects exceed remaining Old Generation space, a Major GC occurs. When Old Generation space is insufficient, a Full GC is triggered. During Major GC, user threads pause, reducing system performance and throughput. Therefore, applications requiring high response times should minimize Major GC occurrences to prevent response timeouts. If GC still cannot accommodate objects copied from the Survivor area after completion, an OOM (Out of Memory) occurs.
#### 1.6 Causes of OutOfMemoryError
OOM (Out of Memory) exceptions commonly occur due to several reasons:

1) Insufficient Old Generation memory: java.lang.OutOfMemoryError: Java heap space

2) Insufficient Permanent Generation memory: java.lang.OutOfMemoryError: PermGen space

3) Code bugs, preventing timely memory release. OOM can occur in any of these memory regions. When encountering OOM, the exception message can help identify which region caused the memory overflow. Adding the parameter -XX:+HeapDumpOnOutMemoryError allows the JVM to dump the current memory heap snapshot upon encountering an OOM exception for later analysis.
#### 1.7 JVM Tuning
Familiarizing oneself with Java memory management mechanisms and configuration parameters, here are some tuning configurations for Java application startup options:

1. Set the minimum heap size -Xms and maximum size -Xmx equal to avoid reallocating memory after each garbage collection.

2. Set the GC garbage collector to G1, -XX:+UseG1GC

3. Enable GC logging for later analysis -Xloggc:../logs/gc.log
## 2 Built-in Views
![JVM.png](../images/jvm-13.png)
## 3 Performance Metrics
| Metric | Description | Data Type | Unit |
| --- | --- | --- | --- |
| buffer_pool_direct_capacity | Total size of direct buffers | int | Byte |
| buffer_pool_direct_count | Number of direct buffers | int | count |
| buffer_pool_direct_used | Used size of direct buffers | int | Byte |
| buffer_pool_mapped_capacity | Total size of mapped buffers | int | Byte |
| buffer_pool_mapped_count | Number of mapped buffers | int | count |
| buffer_pool_mapped_used | Used size of mapped buffers | int | Byte |
| cpu_load_process | Process CPU percentage | decimal | percent |
| cpu_load_system | System CPU percentage | decimal | percent |
| gc_eden_size | Size of Eden region in Young Generation | int | Byte |
| gc_survivor_size | Size of Survivor region in Young Generation | int | Byte |
| gc_old_gen_size | Size of Old Generation | int | Byte |
| gc_metaspace_size | Size of Metaspace | int | Byte |
| gc_major_collection_count | Number of Major GCs in Old Generation | int | count |
| gc_major_collection_time | Time spent on Major GCs in Old Generation | int | ms |
| gc_minor_collection_count | Number of Minor GC| gc_minor_collection_time | Time spent on Minor GCs in Young Generation | int | ms |
| heap_memory_committed | Committed heap memory size | int | Byte |
| heap_memory_init | Initial heap memory size | int | Byte |
| heap_memory_max | Maximum heap memory size | int | Byte |
| heap_memory | Used heap memory size | int | Byte |
| loaded_classes | Number of loaded classes | int | count |
| non_heap_memory_committed | Committed non-heap memory size | int | Byte |
| non_heap_memory_init | Initial non-heap memory size | int | Byte |
| non_heap_memory_max | Maximum non-heap memory size | int | Byte |
| non_heap_memory | Used non-heap memory size | int | Byte |
| os_open_file_descriptors | Number of open file descriptors | int | count |
| thread_count | Total number of threads | int | count |

## More Information:

- [How to Collect JVM Metrics Using <<< custom_key.brand_name >>>](/integrations/jvm.md)

---

This completes the translation of the provided content. If you need further assistance or have additional sections to translate, please let me know!