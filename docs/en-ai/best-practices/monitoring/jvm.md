# Best Practices for JVM Observability

---

## Prerequisites
Go to the official website [Guance](https://guance.com/) to register an account and log in using your registered account/password.
## Install DataKit

### Obtain Command

Click on the [**Integration**] module, [**DataKit**], and choose the appropriate installation command based on your operating system and type.

![](../images/jvm-1.png)

### Execute Installation

Copy the DataKit installation command and run it directly on the server that needs to be monitored.

- Installation directory `/usr/local/datakit/`
- Log directory `/var/log/datakit/`
- Main configuration file `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory `/usr/local/datakit/conf.d/`

### Default Plugins Installed with DataKit

After DataKit is installed, common Linux host plugins are enabled by default. You can view basic information in the host under the workspace—Infrastructure.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO statistics of the host |
| mem | Collects memory usage of the host |
| swap | Collects Swap memory usage |
| system | Collects host OS load |
| net | Collects network traffic statistics of the host |
| host_process | Collects resident (surviving more than 10min) process list |
| hostobject | Collects basic host information (such as OS info, hardware info, etc.) |
| docker | Collects possible container objects and container logs |

### Built-in Views

Click on the [**Infrastructure**] module to view the list of all hosts with DataKit installed and their basic information such as hostname, CPU, memory, etc.

![image.png](../images/jvm-2.png)

## JVM Collection Configuration:
### JAVA_OPTS Declaration
This example uses ddtrace to collect JVM metrics from Java applications. Define JAVA_OPTS according to your requirements and replace JAVA_OPTS when starting the application. The jar startup method is as follows:

```java
java ${JAVA_OPTS} -jar your-app.jar
```

The complete JAVA_OPTS are as follows:

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

Detailed Explanation:

```
-Ddd.env: Environment type of the application, optional 
-Ddd.tags: Custom tags, optional    
-Ddd.service.name: Application name for JVM data source, required  
-Ddd.agent.host=localhost    DataKit address, optional  
-Ddd.agent.port=9529         DataKit port, required  
-Ddd.version: Version, optional 
-Ddd.jmxfetch.check-period Indicates collection frequency in milliseconds, default 1500, optional   
-Ddd.jmxfetch.statsd.host=127.0.0.1 statsd collector connection address same as DataKit address, optional  
-Ddd.jmxfetch.statsd.port=8125 Indicates UDP connection port of the statsd collector on DataKit, default 8125, optional   
-Ddd.trace.health.metrics.statsd.host=127.0.0.1 Self-metric data collection send address same as DataKit address, optional 
-Ddd.trace.health.metrics.statsd.port=8125 Self-metric data collection send port, optional   
-Ddd.service.mapping: Aliases for services called by the application like redis, mysql, optional 
```
For more details about JVM, refer to [JVM](../../integrations/jvm.md) collector
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

Restart datakit

```shell
$ datakit --restart
```

Start jar, replace `your-app` with your application name. If your application is not connected to MySQL, remove `-Ddd.service.mapping=mysql:mysql01`, where `mysql01` is the alias of MySQL seen in DataFlux Func APM.

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

Open external access ports

Edit the `/usr/local/datakit/conf.d/vim datakit.conf` file and change `listen = "0.0.0.0:9529"`

![image.png](../images/jvm-3.png)

Restart datakit

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

**Docker run launch**, modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application port, replace `your-app` with your application name, replace `your-app-image:v1` with your image name

```shell
docker run  -v /tmp/work:/tmp/work -e JAVA_OPTS="-javaagent:/tmp/work/dd-java-agent.jar -Ddd.service.name=your-app  -Ddd.service.mapping=mysql:mysql01 -Ddd.env=dev  -Ddd.agent.host=172.16.0.215 -Ddd.agent.port=9529  -Ddd.jmxfetch.statsd.host=172.16.0.215  " --name your-app -d -p 9299:9299 your-app-image:v1

```
**Docker compose launch**

Dockerfile needs to declare ARG parameters to receive arguments passed from docker-compose, as shown below:

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

Save the above content to `/usr/local/java/DockerfileTest` file, create a `docker-compose.yml` file in the same directory, modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application port, replace `your-app` with your application name, replace `your-app-image:v1` with your image name. `docker-compose.yml` example as follows:

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

Launch

```shell
$ cd /usr/local/java
# Build image
$ docker build -t your-app-image:v1 .
# Launch
$ docker-compose up -d
```

### 3 Kubernetes Usage Method

#### 3.1 Deploy DataKit

Deploy DataKit in Kubernetes using DaemonSet. Refer to <[Datakit DaemonSet Deployment](../../datakit/datakit-daemonset-deploy.md)> 

To collect JVM metrics, enable ddtrace and statsd collectors by adding `statsd, ddtrace` to the ENV_DEFAULT_ENABLED_INPUTS environment variable in the YAML file.

```yaml
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,kubernetes,container,statsd,ddtrace
        
```

This deployment file is `/usr/local/k8s/datakit-default.yaml`, with content as follows:

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

        ## If the data sent failure, will retry forever
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

Find the openway address on [https://console.guance.com/](https://console.guance.com/) as shown in the figure below, and replace the value of ENV_DATAWAY in `datakit-default.yaml`.

![1631933361(1).png](../images/jvm-5.png)

Deploy Datakit

```shell
$ cd /usr/local/k8s
$ kubectl apply -f datakit-default.yaml
$ kubectl get pod -n datakit
```

![image.png](../images/jvm-4.png)

If you need to collect system logs, refer to the following content:

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

          ## glob filter
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

Since `dd-java-agent.jar` is used in the jar usage method but may not exist in the user's image, we need to create an image containing `dd-java-agent.jar` and start it as a sidecar before the business container starts to provide `dd-java-agent.jar` via shared storage.

```
pubrepo.jiagouyun.com/datakit-operator/dd-lib-java-init
```

#### 3.3 Write the Dockerfile for the Java Application
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

Build the image and push it to the harbor repository, replace `172.16.0.215:5000/dk` with your image repository

```shell
$ cd /usr/local/k8s/agent
$ docker build -t 172.16.0.215:5000/dk/your-app-image:v1 . 
$ docker push 172.16.0.215:5000/dk/your-app-image:v1  
```

#### 3.4 Write Deployment

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

Note that in JAVA_OPTS, `-Ddd.tags=container_host:$(PODE_NAME)` passes the value of the environment variable PODE_NAME to the tag container_host. Replace `9299` with your application port, `your-app-name` with your service name, `30001` with the exposed port of your application, and `172.16.0.215:5000/dk/your-app-image:v1` with your image name.

![image.png](../images/jvm-6.png)

Launch

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f your-app-deployment-yaml
```

### Create a New JVM Observability Scenario:

Log in to [Guance](https://guance.com/) and enter the workspace, click [Create New Scenario]

![1631933819(1).png](../images/jvm-7.png)

Click [JVM Monitoring Scenario]

![1631933680(1).png](../images/jvm-8.png)

Enter the scenario name [JVM Monitoring Scenario], click Confirm

![1631933860(1).png](../images/jvm-9.png)

Locate the JVM monitoring view, hover over it and click Create

JVM monitoring view as follows:

![image.png](../images/jvm-10.png)


## Introduction to JVM and Related Metrics
### 1 Overview of JVM
#### 1.1 What is JVM
JVM stands for Java Virtual Machine, which runs on top of the operating system and executes Java bytecode.

#### 1.2 Class Loading Mechanism
Java source files are first compiled into bytecode by the Java compiler, then loaded by the class loader in the JVM, and finally executed by the JVM execution engine.

#### 1.3 Lifecycle of Classes
A Java class goes through seven stages from creation to destruction: Loading, Verification, Preparation, Resolution, Initialization, Using, and Unloading. Verification, Preparation, and Resolution together form Linking.

![image.png](../images/jvm-11.png)

#### 1.4 JVM Memory Structure
During the entire class loading process, the JVM uses a segment of space to store data and related information, known as JVM memory. According to the JVM specification, JVM memory is divided into several regions:

- Execution Engine

Java is a cross-platform programming language, and the execution engine translates bytecode into machine instructions understandable by the platform.

- Program Counter

The program counter is a small memory area that acts as an indicator of the current byte code line number being executed by the thread. In the virtual machine concept model, the bytecode interpreter changes this counter's value to select the next bytecode instruction to execute. Features like branching, looping, jumping, exception handling, and thread recovery depend on this counter.

Characteristics: occupies very little memory, negligible; thread-isolated; when executing native methods, the program counter value is empty; this memory region is the only one in the Java Virtual Machine specification that does not specify any OutOfMemoryError situations.

- Virtual Machine Stack

Describes the memory model for Java method execution. Each method creates a "stack frame (Stack Frame)" during execution, i.e., thread-private, with a lifecycle consistent with the thread. Stack frames are divided into local variable tables, operand stack, dynamic links, and method exits.

We commonly refer to "heap memory" and "stack memory," where "stack memory" refers to the virtual machine stack, specifically the local variable table in the stack frame because it stores all local variables of a method. When a method is called, a stack frame is created and pushed onto the virtual machine stack; when the method finishes executing, the stack frame is popped off and destroyed.

JVM allocates a certain amount of memory to each thread's virtual machine stack (-Xss parameter), and if a single thread requests a stack depth greater than allowed by the JVM, it throws a StackOverflowError (stack overflow error). When the entire virtual machine stack memory is exhausted and cannot allocate new memory, it throws an OutOfMemoryError exception.

- Native Method Stack

The native method stack functions similarly to the virtual machine stack, both having thread isolation characteristics and capable of throwing StackOverflowError and OutOfMemoryError exceptions.

However, the native method stack serves native methods executed by the JVM, while the virtual machine stack serves Java methods executed by the JVM. How does it serve native methods? Which language implements native methods? How does it organize data structures like stack frames? The JVM specification does not provide mandatory rules, so different virtual machines can implement them freely. The commonly used HotSpot virtual machine merges the virtual machine stack and the native method stack.

- Method Area

In JDK8, the permanent generation is deprecated, moving the runtime constant pool and compiled code of each class to another block of native memory not connected to the heap—the Metaspace.

Metaspace: Metaspace is the implementation of the method area in the HotSpot JVM, primarily storing class information, constant pools, method data, method code, symbol references, etc. Metaspace essentially resembles the permanent generation, both implementations of the JVM specification's method area. However, the biggest difference between Metaspace and the permanent generation is that Metaspace resides outside the virtual machine, using native memory. Theoretically, it depends on the size of the 32-bit/64-bit system memory and can be configured with -XX:MetaspaceSize and -XX:MaxMetaspaceSize.

Metaspace has two parameters: MetaspaceSize: initial Metaspace size, controlling GC thresholds. MaxMetaspaceSize: limiting the upper bound of Metaspace size, preventing excessive physical memory consumption.

- Heap

The heap is shared by all threads, mainly storing object instances and arrays. It can be located in physically discontinuous spaces but logically continuous.

Heap memory is divided into Young Generation, Old Generation. The young generation is further divided into Eden and Survivor areas. The Survivor area consists of FromSpace and ToSpace. Eden occupies a larger capacity, while Survivor two areas occupy smaller capacities, with a default ratio of 8:1:1.

If there is insufficient memory in the Java heap to complete instance allocation and the heap cannot expand further, the Java virtual machine throws an OutOfMemoryError exception.

Common JVM heap memory parameters

| **Parameter** | **Description** |
| --- | --- |
| -Xms | Initial heap size, units m, g |
| -Xmx（MaxHeapSize） | Maximum allowed heap size, generally no more than 80% of physical memory |
| -XX:PermSize | Initial non-heap memory size, usually set to 200m initially, maximum 1024m |
| -XX:MaxPermSize | Maximum allowed non-heap memory size |
| -XX:NewSize（-Xns） | Initial young generation memory size |
| -XX:MaxNewSize（-Xmn） | Maximum allowed young generation memory size, can also be abbreviated |
| -XX:SurvivorRatio=8 | Ratio of Eden area to Survivor area in the young generation, default 8, i.e., 8:1 |
| -Xss | Stack memory size |

- Runtime Data Areas

The Java virtual machine divides the memory it manages into several different data regions during the execution of Java programs. These regions have different purposes and creation and destruction times, with some existing as long as the virtual machine process runs, and others dependent on the start and end of user threads.

According to the Java Virtual Machine Specification (Java SE 8 Edition), the runtime data areas managed by the Java virtual machine include: Program Counter, Java Virtual Machine Stack, Native Method Stack, Java Heap, Method Area.

![image.png](../images/jvm-12.png)

- Direct Memory

Direct memory is not part of the runtime data area of the virtual machine and is not defined in the Java Virtual Machine Specification. It is not limited by the Java heap size but is restricted by the total memory size of the native system.

Direct memory can also be specified using -XX:MaxDirectMemorySize. Allocating direct memory consumes higher performance, but direct memory I/O read/write performance is superior to ordinary heap memory. Exhausting direct memory throws an OutOfMemoryError exception.

- Garbage Collection

Program Counter, Virtual Machine Stack, and Native Method Stack are created and destroyed with the thread (because they are thread-private), and stack frames are orderly pushed and popped as methods enter and exit. However, the Java Heap and Method Area are different. Multiple implementations of an interface may require different amounts of memory, and multiple branches within a method may require different amounts of memory. Only during the runtime do we know which objects will be created, making this part of memory allocation and garbage collection dynamic.

Garbage Collectors:

Serial Collector

Parallel Collector

CMS Collector (Concurrent Mark Sweep)

G1 Collector (Garbage First)

Garbage Collection Algorithms (GC, Garbage Collection):

Mark-Sweep

Copying

Mark-Compact
#### 1.5 GC, Full GC
To support generational garbage collection, Java heap memory is divided into three generations: young generation, old generation, and permanent generation. Whether permanent generation performs GC depends on the JVM. Newly generated objects are placed in the young generation Eden area first, large objects go directly to the old generation, and when the Eden area lacks sufficient space, a Minor GC is triggered. Surviving objects move to the Survivor0 area, and when Survivor0 is full, another Minor GC is triggered, moving surviving objects to Survivor1, ensuring one survivor area remains empty for a period. After multiple Minor GCs (default 15 times), surviving objects move to the old generation. The old generation stores long-lived objects, and when promoted objects exceed the remaining space in the old generation, a Major GC occurs. When the old generation space is insufficient, a Full GC is triggered. During Major GC, user threads pause, reducing system performance and throughput. Applications requiring high response times should minimize Major GCs to avoid timeouts. If GC still cannot accommodate objects copied from the Survivor area after completion, an OOM (Out of Memory) occurs.
#### 1.6 Causes of OutOfMemoryError
OOM (Out of Memory) errors commonly occur due to several reasons:

1) Insufficient old generation memory: java.lang.OutOfMemoryError: Java heap space

2) Insufficient permanent generation memory: java.lang.OutOfMemoryError: PermGen space

3) Code bugs causing memory not to be reclaimed timely. OOM can occur in these memory regions, and the actual OOM can be identified by the exception message. Adding the parameter -XX:+HeapDumpOnOutMemoryError allows the JVM to dump the current memory heap snapshot upon an OOM for later analysis.
#### 1.7 JVM Tuning
Familiarity with Java memory management mechanisms and configuration parameters leads to tuning Java application startup options:

1 Set the minimum heap memory -Xms and maximum value -Xmx to be equal to avoid reallocating memory after each garbage collection

2 Set the GC garbage collector to G1, -XX:+UseG1GC

3 Enable GC logs for later analysis -Xloggc:../logs/gc.log
## 2 Built-in Views
![JVM.png](../images/jvm-13.png)
## 3 Performance Metrics
| Metric | Description | Data Type | Unit |
| --- | --- | --- | --- |
| buffer_pool_direct_capacity | Total direct buffer pool size | int | Byte |
| buffer_pool_direct_count | Direct buffer pool count | int | count |
| buffer_pool_direct_used | Used direct buffer pool size | int | Byte |
| buffer_pool_mapped_capacity | Total mapped buffer pool size | int | Byte |
| buffer_pool_mapped_count | Mapped buffer pool count | int | count |
| buffer_pool_mapped_used | Used mapped buffer pool size | int | Byte |
| cpu_load_process | Process CPU percentage | decimal | percentage |
| cpu_load_system | System CPU percentage | decimal | percentage |
| gc_eden_size | Young generation Eden area size | int | Byte |
| gc_survivor_size | Young generation Survivor area size | int | Byte |
| gc_old_gen_size | Old generation size | int | Byte |
| gc_metaspace_size | Metaspace size | int | Byte |
| gc_major_collection_count | Old generation GC count | int | count |
| gc_major_collection_time | Old generation GC time | int | ms |
| gc_minor_collection_count | Young generation GC count | int | count |
| gc_minor_collection_time | Young generation GC time | int | ms |
| heap_memory_committed | Committed heap memory bytes | int | Byte |
| heap_memory_init | Initial heap memory bytes | int | Byte |
| heap_memory_max | Maximum heap memory bytes | int | Byte |
| heap_memory | Used heap memory bytes | int | Byte |
| loaded_classes | Loaded class count | int | count |
| non_heap_memory_committed | Committed non-heap memory bytes | int | Byte |
| non_heap_memory_init | Initial non-heap memory bytes |