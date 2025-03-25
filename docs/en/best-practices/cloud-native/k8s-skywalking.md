# Kubernetes Cluster Application Using SkyWalking to Collect Tracing Data

---

## Introduction

In a Kubernetes cluster, applications are deployed in the form of images. When using SkyWalking to collect application tracing data, if you follow the traditional method of embedding the SkyWalking Agent into each application image before deployment, it will result in bloated images and make future upgrades of SkyWalking versions inconvenient. This article introduces a method that uses the official SkyWalking image with `initContainers` to provide the SkyWalking Agent for the application to collect tracing data.

## Prerequisites

### Install DataKit

- <Install [DataKit](../../datakit/datakit-daemonset-deploy.md)>
- DataKit version >= 1.4.15

### Enable Input 

Enable the Skywalking collector by adding the `/usr/local/datakit/conf.d/skywalking/skywalking.conf` file on the server where DataKit is located. When deploying via DaemonSet, you need to define a ConfigMap first and then mount the file into the DataKit container. The following steps will require the `datakit.yaml` used during the DataKit deployment.

#### Define skywalking.conf

Add the definition of `skywalking.conf` in the ConfigMap resource section of the `datakit.yaml` file.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: datakit-conf
  namespace: datakit
data:  
    ## Below is the new content
    skywalking.conf: |- 
        [[inputs.skywalking]]
          ## skywalking grpc server listening on address
          address = "0.0.0.0:11800"
```

#### Mount skywalking.conf

Add the following content under the `volumeMounts` section of the `datakit.yaml` file.

```yaml
        - mountPath: /usr/local/datakit/conf.d/skywalking/skywalking.conf
          name: datakit-conf
          subPath: skywalking.conf
```

#### Restart DataKit

```shell
kubectl delete -f datakit.yaml
kubectl apply -f datakit.yaml
```

### Java Tracing Data Integration

#### Write Test Application

The example uses [datakit-springboot-demo](https://github.com/stevenliu2020/datakit-springboot-demo). After downloading, create a jar file named `service-demo-1.0-SNAPSHOT.jar`.

#### Create Image

Write a Dockerfile.

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

Create the image and upload it to the image repository.

```shell
docker build -t 172.16.0.246/df-demo/service-demo:v1 .
docker push 172.16.0.246/df-demo/service-demo:v1
```

#### Deploy Application

In the `skywalking-demo.yaml` file used for application deployment, use `initContainers` to initialize the `apache/skywalking-java-agent:8.7.0-alpine` image. Applications within the same Pod can access the `skywalking-agent.jar`. Then define the startup command in `JAVA_OPTS`, where `-Dskywalking.agent.service_name=skywalking-demo-master` defines the alias of the application as `skywalking-demo-master`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: skywalking-demo-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: skywalking-demo-pod
  template:
    metadata:
      labels:
        app: skywalking-demo-pod
      annotations:
    spec:
      containers:
      - name: skywalking-demo-demo-container
        image: 172.16.0.246/df-demo/service-demo:v1
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
        - name: JAVA_OPTS
          value: |-
                -javaagent:/skywalking/agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-demo-master  -Dskywalking.collector.backend_service=$(HOST_IP):11800           
        ports:
        - containerPort: 8090
          protocol: TCP
        volumeMounts:
        - mountPath: /skywalking
          name: skywalking-agent
      initContainers:
        - name: agent-container
          image: apache/skywalking-java-agent:8.7.0-alpine
          volumeMounts:
            - name: skywalking-agent   
              mountPath: /agent
          command: [ "/bin/sh" ]
          args: [ "-c", "cp -R /skywalking/agent /agent/" ]  
      restartPolicy: Always
      volumes:
        - name: skywalking-agent
          emptyDir: {}
```

```shell
kubectl apply -f skywalking-demo.yaml 
```

#### Access Application

Check the pod port.

![image](../images/k8s-skywalking/1.png)	

Call the application to generate tracing data.

```shell
curl 10.244.36.98:8090/ping
```

#### Application Performance Monitoring

Log in to ‘[<<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site >>>/)’, go to the ‘APM’ module, and view the `skywalking-demo-master` application.

![image](../images/k8s-skywalking/2.png)