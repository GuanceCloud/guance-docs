# Inject dd-java-agent using datakit-operator

---

## Introduction

In a Kubernetes environment, when integrating Java applications with APM, the `dd-java-agent.jar` package is required. To avoid modifying the application's image, a common approach is to use initContainers in the deployment YAML to leverage shared storage within the same Pod for using `dd-java-agent.jar`. This method results in repetitive initContainers sections across multiple deployment files.

Can these repetitive sections be extracted to reduce redundancy? The answer is yes. This can be achieved using the open-source [Admission Controller (Admission Controllers)](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/admission-controllers/) from Guance. [datakit-operator](https://github.com/GuanceCloud/datakit-operator) provides functionality to inject dd-lib files and environment variables into specific Pods, currently supporting Java, Python, and JavaScript.

## Prerequisites

- You need to create a [Guance account](https://www.guance.com/).
- A Kubernetes cluster.
- Deploy DataKit using [DaemonSet](../../datakit/datakit-daemonset-deploy.md) and enable the ddtrace collector.

## Procedure

???+ warning

    The version information used in this example is: DataKit `1.5.2`, Kubernetes `1.24`

### 1 Deploy datakit-operator

Download `datakit-operator.yaml` and deploy it to your Kubernetes cluster.

```
wget https://static.guance.com/datakit-operator/datakit-operator.yaml
kubectl apply -f datakit-operator.yaml
```

### 2 Deploy Application

#### 2.1 Write Dockerfile

Write the Dockerfile for your application, mainly exposing JAVA_OPTS to facilitate the injection of the javaagent package externally.

```dockerfile
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

After completing the Dockerfile, push the image to your repository. In this example, we directly pull the image `172.16.0.246/df-demo/service-log-demo:v1`.

#### 2.2 Modify Application YAML

Add an annotation to the application's YAML.

```yaml
      annotations:
        admission.datakit/java-lib.version: ""
```

#### 2.3 Modify Application YAML

Declare the JAVA_OPTS environment variable. The application can now access the automatically injected `/datadog-lib/dd-java-agent.jar` package. Refer to [javaagent parameters](../../integrations/ddtrace-java.md#start-options) for startup options. Here, the service name is set to `java-demo-service`.

```yaml
        - name: JAVA_OPTS
          value: |-
            -javaagent:/datadog-lib/dd-java-agent.jar -Ddd.service.name=java-demo-service -Ddd.tags=container_host:$(POD_NAME) -Ddd.env=dev -Ddd.agent.port=9529
```

??? quote "Example complete `java-demo.yaml`"

    ```yaml
    apiVersion: v1
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
            admission.datakit/java-lib.version: ""
        spec:
          containers:
          - name: guance-demo-container
            image: 172.16.0.246/df-demo/service-log-demo:v1
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
            #- name: DD_AGENT_HOST
            #  valueFrom:
            #    fieldRef:
            #      apiVersion: v1
            #      fieldPath: status.hostIP
            - name: JAVA_OPTS
              value: |-
                -javaagent:/datadog-lib/dd-java-agent.jar -Ddd.service.name=java-demo-service -Ddd.tags=container_host:$(POD_NAME) -Ddd.env=dev -Ddd.agent.port=9529
            ports:
            - containerPort: 8090
              protocol: TCP
            volumeMounts:
            - mountPath: /data/app/logs
              name: varlog
          restartPolicy: Always
          volumes:
          - name: varlog
            emptyDir: {}


    ```

#### 2.4 Deploy Application

```
kubectl apply -f java-demo.yaml
```

### 3 Trace Reporting

Obtain the pod's IP address and access the application's interface to generate trace data.

![image.png](../images/datakit-operator1.png)

Log in to the [Guance Console](https://console.guance.com/) -> [APM] and query the traces based on the server `java-demo-service`.

![image.png](../images/datakit-operator2.png)