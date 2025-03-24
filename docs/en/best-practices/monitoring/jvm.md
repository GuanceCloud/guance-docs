# Best Practices for JVM Observability

---

## Prerequisites
Go to the official website [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) and register an account, then log in using your registered account/password.
## Installing DataKit

### Getting the Command

Click on the [**Integration**] module, [**DataKit**], and select the appropriate installation command based on your operating system and system type.

![](../images/jvm-1.png)

### Executing Installation

Copy the DataKit installation command and run it directly on the server that needs to be monitored.

- Installation directory `/usr/local/datakit/`
- Log directory `/var/log/datakit/`
- Main configuration file `/usr/local/datakit/conf.d/datakit.conf`
- Plugin configuration directory `/usr/local/datakit/conf.d/`

### Plugins Installed by Default with DataKit

After installing DataKit, the commonly used Linux host plugins are enabled by default. You can view them in the basic information of the host under Workspace —— Infrastructure.

| Collector Name | Description |
| --- | --- |
| cpu | Collects CPU usage of the host |
| disk | Collects disk usage |
| diskio | Collects disk IO usage of the host |
| mem | Collects memory usage of the host |
| swap | Collects swap memory usage |
| system | Collects host operating system load |
| net | Collects network traffic usage of the host |
| host_process | Collects a list of long-running (surviving over 10min) processes on the host |
| hostobject | Collects basic host information (such as OS info, hardware info, etc.) |
| docker | Collects possible container objects and container logs on the host |

### Built-in Views

Click on the [**Infrastructure**] module to view all installed DataKit hosts and their basic information, such as hostname, CPU, memory, etc.

![image.png](../images/jvm-2.png)

## JVM Collection Related Configurations:
### JAVA_OPTS Declaration
This example uses ddtrace to collect JVM metrics from Java applications. Define JAVA_OPTS according to your requirements and replace JAVA_OPTS when starting the application. The following is the way to start the jar:

```java
java ${JAVA_OPTS} -jar your-app.jar
```

Complete JAVA_OPTS as follows:

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
 -Ddd.trace.health.metrics.statsd.port=8125   \
 
```

Detailed Explanation:

```
-Ddd.env: Application environment type, optional  
-Ddd.tags: Custom tags, optional  
-Ddd.service.name: Application name for JVM data sources, required  
-Ddd.agent.host=localhost    DataKit address, optional  
-Ddd.agent.port=9529         DataKit port, required  
-Ddd.version: Version, optional  
-Ddd.jmxfetch.check-period Indicates collection frequency, unit in milliseconds, default 1500, optional  
-Ddd.jmxfetch.statsd.host=127.0.0.1 statsd collector connection address same as DataKit address, optional  
-Ddd.jmxfetch.statsd.port=8125 Indicates UDP connection port of statsd collector on DataKit, default 8125, optional  
-Ddd.trace.health.metrics.statsd.host=127.0.0.1 Self-metric data collection send address same as DataKit address, optional  
-Ddd.trace.health.metrics.statsd.port=8125 Self-metric data collection send port, optional  
-Ddd.service.mapping: Aliases for application calls like redis, mysql, optional  
```
For more detailed information about JVM, please refer to [JVM](../../integrations/jvm.md) collectors
### 1. Using jar method

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

Start the jar, replace `your-app` below with your application name. If your application is not connected to MySQL, remove `-Ddd.service.mapping=mysql:mysql01`, where `mysql01` is the alias for MySQL seen in Dataflux APM.

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

Enable statsd and ddtrace following the jar usage method

Open external access ports

Edit the `/usr/local/datakit/conf.d/vim datakit.conf` file and change `listen = "0.0.0.0:9529"`

![image.png](../images/jvm-3.png)

Restart datakit

```shell
$ datakit --restart
```

Use environment variables JAVA_OPTS in the ENTRYPOINT startup parameters in your Dockerfile. Below is an example Dockerfile:

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

Save the content above into the `/usr/local/java/Dockerfile` file

```shell
$ cd /usr/local/java
$ docker build -t your-app-image:v1 .
```
Copy `/usr/local/datakit/data/dd-java-agent.jar` to the `/tmp/work` directory

**Docker run Startup**, modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application's port, replace `your-app` with your application name, and replace `your-app-image:v1` with your image name.

```shell
docker run  -v /tmp/work:/tmp/work -e JAVA_OPTS="-javaagent:/tmp/work/dd-java-agent.jar -Ddd.service.name=your-app  -Ddd.service.mapping=mysql:mysql01 -Ddd.env=dev  -Ddd.agent.host=172.16.0.215 -Ddd.agent.port=9529  -Ddd.jmxfetch.statsd.host=172.16.0.215  " --name your-app -d -p 9299:9299 your-app-image:v1

```
**Docker compose Startup**

The Dockerfile needs to declare ARG parameters to receive parameters passed from docker-compose. Example:

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

Save the content above into the `/usr/local/java/DockerfileTest` file, create a new `docker-compose.yml` file in the same directory. Modify `172.16.0.215` to your server's internal IP address, replace `9299` with your application's port, replace `your-app` with your application name, and replace `your-app-image:v1` with your image name. Example `docker-compose.yml`:

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

Startup

```shell
$ cd /usr/local/java
# Build image
$ docker build -t your-app-image:v1 .
# Startup
$ docker-compose up -d
```

### 3 Kubernetes Usage Method

#### 3.1 Deploying DataKit

In Kubernetes, deploy DataKit using DaemonSet. Please refer to <[Datakit DaemonSet Installation](../../datakit/datakit-daemonset-deploy.md)>

To collect JVM metrics, enable ddtrace and statsd collectors. In the yaml file's ENV_DEFAULT_ENABLED_INPUTS environment variable for DaemonSet-deployed DataKit, add statsd, ddtrace.

```yaml
- name: ENV_DEFAULT_ENABLED_INPUTS
  value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,kubernetes,container,statsd,ddtrace
        
```

This example's deployment file is `/usr/local/k8s/datakit-default.yaml`, its content is as follows:

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
          value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token>
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
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.2.1
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

Find the openway address at [https://<<< custom_key.studio_main_site >>>/](https://<<< custom_key.studio_main_site >>>/) as shown in the figure below, and replace the value of ENV_DATAWAY in `datakit-default.yaml`.

![1631933361(1).png](../images/jvm-5.png)

Deploy Datakit

```shell
$ cd /usr/local/k8s
$ kubectl apply -f datakit-default.yaml
$ kubectl get pod -n datakit
```

![image.png](../images/jvm-4.png)

If you need to collect system logs in this example, refer to the following content:

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

In the jar usage method, `dd-java-agent.jar` is used, but this jar may not exist in the user's image. To avoid intruding on the customer's business image, we need to create an image containing `dd-java-agent.jar` and launch it as a sidecar to provide `dd-java-agent.jar` via shared storage before the business container starts.

```
pubrepo.<<< custom_key.brand_main_domain >>>/datakit-operator/dd-lib-java-init
```

#### 3.3 Writing the Dockerfile for the Java Application
Use the environment variable JAVA_OPTS in the ENTRYPOINT startup parameters in your Dockerfile. Below is an example Dockerfile:

```bash
FROM openjdk:8u292

ENV jar your-app.jar
ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar}"]
```

Build the image and upload it to the harbor repository, replace `172.16.0.215:5000/dk` below with your image repository.

```shell
$ cd /usr/local/k8s/agent
$ docker build -t 172.16.0.215:5000/dk/your-app-image:v1 . 
$ docker push 172.16.0.215:5000/dk/your-app-image:v1  
```

#### 3.4 Writing Deployment

Create the `/usr/local/k8s/your-app-deployment-yaml` file with the following content:

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

Explanation: In JAVA_OPTS, `-Ddd.tags=container_host:$(PODE_NAME)` passes the value of the environment variable PODE_NAME to the tag `container_host`. Replace `9299` with your application's port, replace `your-app-name` with your service name, replace `30001` with your application's exposed port, and replace `172.16.0.215:5000/dk/your-app-image:v1` with your image name.

![image.png](../images/jvm-6.png)

Startup

```shell
$ cd /usr/local/k8s/
$ kubectl apply -f your-app-deployment-yaml
```

### Creating a New JVM Observability Scenario:

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.brand_main_domain >>>/) and enter the workspace, click [Create Scenario]

![1631933819(1).png](../images/jvm-7.png)

Click [JVM Monitoring Scenario]

![1631933680(1).png](../images/jvm-8.png)

Enter the scenario name [JVM Monitoring Scenario] and click Confirm

![1631933860(1).png](../images/jvm-9.png)

Find the JVM monitoring view in the figure above, hover over it, and click Create

JVM monitoring view is as follows:

![image.png](../images/jvm-10.png)


## Introduction to JVM and Related Metrics
### 1 Overview of JVM
#### 1.1 What is JVM
JVM stands for Java Virtual Machine, which runs on top of the operating system and is used to execute Java bytecode.
#### 1.2 Class Loading Mechanism
First, Java source files are compiled by the Java compiler into bytecode, then loaded by the class loader in the JVM, after loading, it is handed over to the JVM execution engine for execution.
#### 1.3 Class Lifecycle
A Java class goes through seven stages from start to finish: Loading, Verification, Preparation, Resolution, Initialization, Usage, and Unloading. Among these, Verification, Preparation, and Resolution are collectively referred to as Linking.

![image.png](../images/jvm-11.png)

#### 1.4 JVM Memory Structure
During the entire class loading process, the JVM uses a segment of space to store data and related information. This segment of space is what we usually call JVM memory. According to the JVM specification, JVM memory is divided into:

- Execution Engine

Java is a cross-platform programming language, and the execution engine translates bytecode into machine instructions recognizable by the corresponding platform.

- Program Counter

The program counter is a small block of memory whose function can be seen as the line number indicator of the bytecode being executed by the current thread. In the conceptual model of the virtual machine, the bytecode interpreter works by changing this counter value to select the next bytecode instruction to be executed. Branches, loops, jumps, exception handling, thread resumption, and other basic functions all depend on this counter to complete.

Characteristics: occupies very little memory, negligible; thread isolated; when executing native local methods, the value of the program counter is empty; this memory area is the only one in the Java virtual machine specification that does not specify any OutOfMemoryError conditions.

- Virtual Machine Stack

Describes the memory model of Java method execution. Each method creates a "stack frame (Stack Frame)" when executed, i.e., thread-private, with a lifecycle consistent with the thread. The structure of the stack frame is divided into several parts: local variable table, operand stack, dynamic linking, method exit.

What we often refer to as "heap memory" and "stack memory" refers to the virtual machine stack, specifically the local variable table in the stack frame of the virtual machine stack because it stores all local variables of a method. When a method is called, a stack frame is created and pushed onto the virtual machine stack; when the method execution is complete, the stack frame is popped out and destroyed.

The JVM allocates a certain amount of memory for each thread's virtual machine stack (-Xss parameter). If the stack depth requested by a single thread exceeds the allowed depth of the virtual machine, a StackOverflowError (stack overflow error) will be thrown. When the entire virtual machine stack memory is exhausted and no new memory can be allocated, an OutOfMemoryError exception is thrown.

- Native Method Stack

The functionality and characteristics of the native method stack are similar to those of the virtual machine stack, both having thread isolation features and both capable of throwing StackOverflowError and OutOfMemoryError exceptions.

The difference is that the native method stack serves the native methods executed by the JVM, while the virtual machine stack serves the Java methods executed by the JVM. How does it serve native methods? What language is used to implement native methods? How to organize data structures like stack frames to serve methods? The virtual machine specification does not give mandatory regulations, so different virtual machines can implement freely. The commonly used HotSpot virtual machine chooses to merge the virtual machine stack and the native method stack.

- Method Area

In JDK8, the permanent generation was deprecated, and the runtime constant pool of each class and the compiled code were moved to another block of local memory not connected to the heap—the Metaspace.

Metaspace (Metaspace): Metaspace is the implementation of the method area in the HotSpot JVM. The method area is mainly used to store class information, constant pools, method data, method code, symbol references, etc. The essence of Metaspace is similar to the permanent generation, both being implementations of the method area in the JVM specification. However, the biggest difference between Metaspace and the permanent generation is that Metaspace is not within the virtual machine but instead uses native memory. Theoretically, it depends on the size of the 32-bit/64-bit system memory and can be configured with -XX:MetaspaceSize and -XX:MaxMetaspaceSize.

Metaspace has two parameters: MetaspaceSize: initial Metaspace size, controlling the GC threshold. MaxMetaspaceSize: limiting the upper bound of the Metaspace size to prevent abnormal consumption of too much physical memory.

- Heap

The heap area is shared by all threads and is mainly used to store object instances and arrays. It can be located in physically discontinuous spaces but must be logically continuous.

Heap memory is divided into Young Generation (Young Generation), Old Generation (Old Generation). The young generation is further divided into Eden and Survivor areas. The Survivor area consists of FromSpace and ToSpace. Eden takes up a large capacity, while the two Survivor areas take up smaller capacities, with a default ratio of 8:1:1.

If there is no memory available in the Java heap to complete instance allocation and the heap cannot be expanded further, the Java virtual machine will throw an OutOfMemoryError exception.

Common JVM heap memory parameters

| **Parameter** | **Description** |
| --- | --- |
| -Xms | Initial heap memory size, units m, g |
| -Xmx (MaxHeapSize) | Maximum allowable heap memory size, generally not exceeding 80% of physical memory |
| -XX:PermSize | Initial non-heap memory size, generally setting initialization to 200m, maximum 1024m is sufficient |
| -XX:MaxPermSize | Maximum allowable non-heap memory size |
| -XX:NewSize (-Xns) | Initial young generation memory size |
| -XX:MaxNewSize (-Xmn) | Maximum allowable young generation memory size, can also be abbreviated |
| -XX:SurvivorRatio=8 | Ratio of Eden area to Survivor area in the young generation, default is 8, i.e., 8:1 |
| -Xss | Stack memory size |

- Runtime Data Area

The Java virtual machine divides the memory it manages into several different data regions during the execution of Java programs. These regions have their own respective purposes, as well as creation and destruction times. Some regions exist with the virtual machine process, while others are established and destroyed depending on the start and end of user threads.

According to the Java Virtual Machine Specification (Java SE 8 Edition), the memory managed by the Java virtual machine will include the following runtime data regions: Program Counter, Java Virtual Machine Stack, Native Method Stack, Java Heap, Method Area.

![image.png](../images/jvm-12.png)

- Direct Memory

Direct memory is not part of the runtime data area of the virtual machine, nor is it a memory region defined in the Java Virtual Machine Specification. It is not limited by the size of the Java heap but is restricted by the total memory size of the local machine.

Direct memory can also be specified with -XX:MaxDirectMemorySize. Applying direct memory consumes higher performance, but the performance of direct memory IO read/write is better than ordinary heap memory. Exhausting memory throws an OutOfMemoryError exception.

- Garbage Collection

The program counter, virtual machine stack, and native method stack follow the thread lifecycle (because they are thread-private), and the stack frames in the stack orderly perform push and pop operations as methods enter and exit. However, the Java heap and method area are different. Multiple implementations of an interface may require different amounts of memory, and multiple branches of a method may also require different amounts of memory. We only know which objects will be created during the program's runtime period. This part of the memory allocation and garbage collection are dynamic, and what the garbage collector focuses on is this part of the memory.

Garbage Collectors:

Serial Collector (Serial)

Parallel Collector (Parallel)

CMS Collector (Concurrent Mark Sweep)

G1 Collector (Garbage First)

Garbage Collection Algorithms (GC, Garbage Collection):

Mark-Sweep

Copy

Mark-Compact
#### 1.5 GC, Full GC
For generational garbage collection, the Java heap memory is divided into three generations: young generation, old generation, and permanent generation. Whether the permanent generation executes GC depends on the JVM used. Newly generated objects are placed in the young generation Eden area first, large objects go directly to the old generation, and when the Eden area does not have enough space, a Minor GC is triggered. Surviving objects move to the Survivor0 area, and when Survivor0 is full, a Minor GC is triggered again, moving surviving objects from Survivor0 to Survivor1, ensuring that one survivor area remains empty for a period of time. Objects that survive multiple Minor GCs (default 15 times) move to the old generation. The old generation stores long-lived objects, and when promoted objects exceed the remaining space in the old generation, a Major GC occurs. When the old generation space is insufficient, a Full GC is triggered. During Major GC, user threads pause, reducing system performance and throughput. Therefore, for high-response applications, try to reduce Major GC occurrences to avoid response timeouts. If GC still cannot accommodate objects copied from the Survivor area, an OOM (Out of Memory) occurs.
#### 1.6 Causes of OutOfMemoryError
Common causes of OOM (Out of Memory) exceptions are:

1) Insufficient old generation memory: java.lang.OutOfMemoryError: Java heap space

2) Insufficient permanent generation memory: java.lang.OutOfMemoryError: PermGen space

3) Code bugs, memory unable to be reclaimed in time. OOM can occur in any of these memory regions, and when encountering OOM, you can locate which region's memory overflow based on the exception information. You can add the parameter -XX:+HeapDumpOnOutMemoryError to let the virtual machine dump the current memory heap snapshot when an OOM exception occurs for later analysis.
#### 1.7 JVM Optimization
After familiarizing yourself with the JAVA memory management mechanism and configuration parameters, here are optimizations for JAVA application startup options:

1 Set the minimum heap memory -Xms and maximum -Xmx to be equal to avoid re-allocating memory after each garbage collection

2 Set the GC garbage collector to G1, -XX:+UseG1GC

3 Enable GC logs for easier analysis later -Xloggc:../logs/gc.log
## 2 Built-in Views
![JVM.png](../images/jvm-13.png)
## 3 Performance Metrics
| Metric | Description | Data Type | Unit |
| --- | --- | --- | --- |
| buffer_pool_direct_capacity | Total size of direct buffer pool | int | Byte |
| buffer_pool_direct_count | Count of direct buffer pool | int | count |
| buffer_pool_direct_used | Size used in direct buffer pool | int | Byte |
| buffer_pool_mapped_capacity | Total size of mapped memory buffer pool | int | Byte |
| buffer_pool_mapped_count | Count of mapped memory buffer pool | int | count |
| buffer_pool_mapped_used | Size used in mapped memory buffer pool | int | Byte |
| cpu_load_process | Percentage of CPU usage by the process | decimal | percentage |
| cpu_load_system | Percentage of CPU usage by the system | decimal | percentage |
| gc_eden_size | Size of the Eden region in young generation | int | Byte |
| gc_survivor_size | Size of the Survivor region in young generation | int | Byte |
| gc_old_gen_size | Size of the old generation | int | Byte |
| gc_metaspace_size | Size of the Metaspace | int | Byte |
| gc_major_collection_count | Number of GC events in the old generation | int | count |
| gc_major_collection_time | Time spent on GC in the old generation | int | ms |
| gc_minor_collection_count | Number of GC events in the young generation | int | count |
| gc_minor_collection_time | Time spent on GC in the young generation | int | ms |
| heap_memory_committed | Committed bytes in heap memory | int | Byte |
| heap_memory_init | Initial bytes in heap memory | int | Byte |
| heap_memory_max | Maximum bytes in heap memory | int | Byte |
| heap_memory | Used bytes in heap memory | int | Byte |
| loaded_classes | Number of loaded classes | int | count |
| non_heap_memory_committed | Committed bytes in non-heap memory | int | Byte |
| non_heap_memory_init | Initial bytes in non-heap memory | int | Byte |
| non_heap_memory_max | Maximum bytes in non-heap memory | int | Byte |
| non_heap_memory | Used bytes in non-heap memory | int | Byte |
| os_open_file_descriptors | Open file descriptors | int | count |
| thread_count | Total number of threads | int | count |

## For more information:

- [How to use <<< custom_key.brand_name >>> to collect JVM metrics](/integrations/jvm.md)