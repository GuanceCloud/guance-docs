# Best Practices for Reporting Kubernetes Cluster Logs to the Same Node's DataKit

---

## Introduction

In a Kubernetes cluster, when using DaemonSet-deployed DataKit to collect metrics, traces, and log data, the best way to improve interaction performance between Pods and DataKit is to use the DataKit deployed on the same node as the Pod to collect these data. With DataKit deployed via DaemonSet, each node in the cluster will start one DataKit. Simply routing traffic to the DataKit on that node enables data collection from the same node.

![image](../images/log-report-one-node/1.png)

In the Kubernetes Service resource, there is a field called "externalTrafficPolicy" which can be set to either Cluster or Local policies. Using this external policy requires that the service type of the Service be NodePort or LoadBalancer.

1. Cluster: Traffic can be forwarded to Pods on other nodes, which is the default mode.
2. Local: Traffic is only sent to Pods on the local machine.

By default, in Cluster mode, Kube-proxy receives request traffic and performs SNAT (source network address translation) during forwarding, changing the source IP to the node's IP. This ensures that requests return along the original path. After switching to Local mode, Kube-proxy retains the source IP during request forwarding and forwards only to Pods on the local node, never across nodes.

## Installation and Deployment

### Deploying DataKit

##### 1.1.1 Download Deployment Files

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) and click on the 'Integration' module, then click 'DataKit' in the top-left corner, select 'Kubernetes', and download datakit.yaml.

##### 1.1.2 Configure Token

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/), enter the 'Management' module, find the token shown in the figure below, and replace the value of the ENV_DATAWAY environment variable in the datakit.yaml file with <your-token>.

```yaml
        - name: ENV_DATAWAY
          value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token>
```

![image](../images/log-report-one-node/2.png)

##### 1.1.3 Set Global Tags

Add cluster_name_k8s=k8s-istio at the end of the ENV_GLOBAL_HOST_TAGS environment variable value in the datakit.yaml file, where k8s-istio is the global tag.

```yaml
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=k8s-prod
```

##### 1.1.4 Set Namespace

To distinguish different clusters during DataKit elections, it is necessary to set the ENV_NAMESPACE environment variable. The values for different clusters must not be the same. Add the following content to the environment variable section in the datakit.yaml file.

```yaml
        - name: ENV_NAMESPACE
          value: guance-k8s
```

##### 1.1.5 Enable Collectors

This case uses logfwd to collect logs, so logfwd and pipeline mounting need to be enabled.

```yaml

        volumeMounts:
        # Below is new content
        - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
          name: datakit-conf
          subPath: logfwdserver.conf 
        - mountPath: /usr/local/datakit/pipeline/pod-logging-demo.p
          name: datakit-conf
          subPath: pod-logging-demo.p
```

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:
    #  ... Below is new content
    #### logfwdserver
    logfwdserver.conf: |-
      [inputs.logfwdserver]
        ## logfwd server listening address and port
        address = "0.0.0.0:9531"

        [inputs.logfwdserver.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    pod-logging-demo.p: |-
        # Log format
        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")
        default_time(time,"Asia/Shanghai")
```

##### 1.1.6 Deploy DataKit

```
kubectl apply -f datakit.yaml
```

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
          value: https://openway.<<< custom_key.brand_main_domain >>>?token=<your-token> # Replace with the actual dataway address here
        - name: ENV_GLOBAL_HOST_TAGS
          value: host=__datakit_hostname,host_ip=__datakit_ip
        - name: ENV_DEFAULT_ENABLED_INPUTS
          value: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container
        - name: ENV_ENABLE_ELECTION
          value: enable
        - name: ENV_LOG
          value: stdout
        - name: ENV_HTTP_LISTEN
          value: 0.0.0.0:9529
        - name: ENV_K8S_CLUSTER_NAME
          value: k8s-prod
        - name: ENV_NAMESPACE
          value: guance-k8s
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/datakit:1.2.16
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
        - mountPath: /var/run/docker.sock
          name: docker-socket
          readOnly: true
        - mountPath: /var/run/containerd/containerd.sock
          name: containerd-socket
          readOnly: true
        - mountPath: /usr/local/datakit/conf.d/log/logfwdserver.conf
          name: datakit-conf
          subPath: logfwdserver.conf 
        - mountPath: /usr/local/datakit/pipeline/pod-logging-demo.p
          name: datakit-conf
          subPath: pod-logging-demo.p
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
        #- mountPath: /usr/local/datakit/conf.d/db/mysql.conf
        #  name: datakit-conf
        #  subPath: mysql.conf
        #  readOnly: true
        #- mountPath: /usr/local/datakit/conf.d/db/redis.conf
        #  name: datakit-conf
        #  subPath: redis.conf
        #  readOnly: true
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
          path: /var/run/docker.sock
        name: docker-socket
      - hostPath:
          path: /var/run/containerd/containerd.sock
        name: containerd-socket
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
    #mysql.conf: |-
    #  [inputs.mysql]
    #  ...
    #redis.conf: |-
    #  [inputs.redis]
    #  ...
    #### logfwdserver
    logfwdserver.conf: |-
      [inputs.logfwdserver]
        ## logfwd server listening address and port
        address = "0.0.0.0:9531"

        [inputs.logfwdserver.tags]
        # some_tag = "some_value"
        # more_tag = "some_other_value"
    pod-logging-demo.p: |-
        # Log format
        grok(_, "%{TIMESTAMP_ISO8601:time} %{NOTSPACE:thread_name} %{LOGLEVEL:status}%{SPACE}%{NOTSPACE:class_name} - \\[%{NOTSPACE:method_name},%{NUMBER:line}\\] -  - %{GREEDYDATA:msg}")
        default_time(time,"Asia/Shanghai")

```

### Deploy Application

#### Write Microservices

For convenience in checking which node outputs the logs, the code writes logs by printing out the node server name, where the node IP comes from the HOST_IP environment variable, and the node server name comes from the HOST_NAME environment variable. Complete project [datakit-springboot-demo](https://github.com/stevenliu2020/datakit-springboot-demo).

![image](../images/log-report-one-node/3.png)

![image](../images/log-report-one-node/4.png)

#### Create Image

Write Dockerfile

```
FROM openjdk:8u292

RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone
ENV jar service-demo-1.0-SNAPSHOT.jar

ENV workdir /data/app/
RUN mkdir -p ${workdir}
COPY ${jar} ${workdir}
WORKDIR ${workdir}
ENTRYPOINT ["sh", "-ec", "exec java ${JAVA_OPTS} -jar ${jar} ${PARAMS} "]
```

Place the project Jar and Dockerfile in the same directory. Execute the following commands to build the image and upload it to the private repository.

```shell
docker build -t 172.16.0.238/df-demo/service-demo:v1  .
docker push 172.16.0.238/df-demo/service-demo:v1
```

#### Write Deployment File

Write the demo-service.yaml deployment file and add externalTrafficPolicy: Local in the Service resource file to enable the Local mode of the external strategy. Add HOST_IP and HOST_NAME environment variables for outputting ip and server name.

```shell
 kubectl  apply -f demo-service.yaml
```

For information about using logfwd, refer to [Best Practices for Pod Log Collection](../pod-log). In the specified DataKit environment variables for logfwd, use the domain name datakit-service.datakit.svc.cluster.local for the DataKit Service.

```yaml
        - name: LOGFWD_DATAKIT_HOST
          value: "datakit-service.datakit.svc.cluster.local"
```

The complete content of demo-service.yaml is as follows.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: guance-service
  labels:
    app: guance-service
spec:
  selector:
    app: guance-pod
  externalTrafficPolicy: Local
  ports:
    - protocol: TCP
      port: 8090
      targetPort: 8090
      nodePort: 30090
  type: NodePort  
---

apiVersion: apps/v1
kind: Deployment
metadata:
  name: guance-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: guance-pod
  template:
    metadata:
      labels:
        app: guance-pod
      annotations:          
    spec:
      containers:
      - name: guance-demo-container
        image: 172.16.0.238/df-demo/service-demo:v1
        env:
        - name: HOST_IP
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: status.hostIP
        - name: HOST_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName  
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: DD_AGENT_HOST
          value: $(HOST_IP)    
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=k8s-guance-service  -Ddd.tags=container_host:$(PODE_NAME)  -Ddd.tags=node_ip:$(DD_AGENT_HOST) -Ddd.env=dev -Ddd.agent.port=9529                   
        ports:
        - containerPort: 8090
          protocol: TCP
        volumeMounts:
        - mountPath: /data/app/logs
          name: varlog 
      - name: logfwd
        image: pubrepo.<<< custom_key.brand_main_domain >>>/datakit/logfwd:1.2.12
        env:
        - name: LOGFWD_DATAKIT_HOST
          value: "datakit-service.datakit.svc.cluster.local"
        - name: LOGFWD_DATAKIT_PORT
          value: "9531"
        - name: LOGFWD_ANNOTATION_DATAKIT_LOGS
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: metadata.annotations['datakit/logs']
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
      restartPolicy: Always
      volumes:
      - name: varlog
        emptyDir: {} 
      - configMap:
          name: guance-logfwd-conf
        name: logfwd-config 

---
        
apiVersion: v1
kind: ConfigMap
metadata:
  name: guance-logfwd-conf
data:
  config: |
    [
        {            
            "loggings": [
                {
                    "logfiles": ["/var/log/log.log"],
                    "source": "log_fwd_demo",                    
                    "pipeline": "pod-logging-demo.p",
                    "multiline_match": "^\\d{4}-\\d{2}-\\d{2}",
                    "tags": {
                        "flag": "tag1"
                    }
                }
            ]
        }
    ]

```

### Traffic Verification

Log in to the master node of the cluster and execute the following command to generate logs.

![image](../images/log-report-one-node/5.png)

Log in to [<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/) and go to the 'Logs' module. Search for log_fwd_demo based on the data source and click to view details.

![image](../images/log-report-one-node/6.png)

You can see that the host matches the server name output in the logs completely. Multiple requests show the same reported host.

![image](../images/log-report-one-node/7.png)