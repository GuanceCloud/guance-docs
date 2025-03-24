# Use datakit-operator to inject dd-java-agent

---

## Introduction

In a Kubernetes environment, when integrating Java applications with APM, the `dd-java-agent.jar` package is required. To avoid modifying the application's image, a common approach is to use initContainers in the yaml deployment of the application. This allows the use of `dd-java-agent.jar` by leveraging shared storage among containers within the same Pod. Using this method results in identical initContainers sections appearing in each deployment file.

So, can these identical parts be extracted to further reduce the workload? The answer is yes, and this is where <<< custom_key.brand_name >>>'s open-source [Admission Controller (Admission Controllers)](https://kubernetes.io/en-us/docs/reference/access-authn-authz/admission-controllers/) comes into play. [datakit-operator](https://github.com/GuanceCloud/datakit-operator) provides the function of injecting dd-lib files and environments into special Pods, currently supporting java, python, and js.

## Prerequisites

- You need to first create a [<<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/).
- A Kubernetes cluster.
- [DataKit has been deployed using DaemonSet](../../datakit/datakit-daemonset-deploy.md), and ddtrace collector has been enabled.

## Procedure

???+ warning

    The version information used in this example is: DataKit `1.5.2`, Kubernetes `1.24`

### 1 Deploy datakit-operator

Download `datakit-operator.yaml` and deploy it to the Kubernetes cluster.

```
wget https://static.<<< custom_key.brand_main_domain >>>/datakit-operator/datakit-operator.yaml
kubectl apply -f datakit-operator.yaml
```

### 2 Deploy Application

#### 2.1 Write Dockerfile

Write the Dockerfile for your application, mainly exposing JAVA_OPTS so that the javaagent package can be injected externally.

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

After writing, push the image to the repository; below we directly pull the image using `172.16.0.246/df-demo/service-log-demo:v1`.

#### 2.2 Modify Application yaml

Add annotation to the application's yaml.

```
      annotations:
        admission.datakit/java-lib.version: ""
```

#### 2.3 Modify Application yaml

Declare the JAVA_OPTS environment variable. The application already has access to the automatically injected `/datadog-lib/dd-java-agent.jar` package. Startup parameters can refer to [javaagent Parameters](../../integrations/ddtrace-java.md#start-options). Here, the service name is set to `java-demo-service`.

```
        - name: JAVA_OPTS
          value: |-
            -javaagent:/datadog-lib/dd-java-agent.jar -Ddd.service.name=java-demo-service -Ddd.tags=container_host:$(POD_NAME) -Ddd.env=dev -Ddd.agent.port=9529
```

??? quote "Complete Example `java-demo.yaml`"

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

### 3 Report on the Trace

Get the pod's IP and access the application's interface to generate trace data.

![image.png](../images/datakit-operator1.png)

Log in to 「[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)」- 「APM」, based on the server java-demo-service, you can query the trace.

![image.png](../images/datakit-operator2.png)