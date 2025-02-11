# Best Practices for Observability of Large-Scale Microservices Projects

---

> *Author: Liu Rui*

## Background Introduction

![image.png](../images/mutil-micro-service-1.png)

As you integrate more and more systems into Guance, the **[APM]** list becomes filled with all the collected APM services. Browsing through these services to find the project you want can be overwhelming.<br />

At this point, you might think about having a view similar to RUM that provides an overview of APM, allowing you to quickly check the operational status of each project: how many times were APIs called? How many calls failed? What are the top 10 APIs with the highest latency? etc.

Guance has powerful visualization capabilities and can build project views according to your needs. Assuming you have two Java SpringCloud microservices projects, each with multiple microservices, the following effects can be achieved using Guance's views for your reference:

- **Project A ：**

![image.png](../images/mutil-micro-service-2.png)

- **Project B ：**

![image.png](../images/mutil-micro-service-3.png)

## Prerequisites

- You have already integrated APM into Guance.

- Your application is deployed in a K8s environment (the steps for non-K8s environments are basically the same, except you don't modify YAML files).

- You have multiple projects (e.g., Project A, Project B), but this approach also supports single projects.

- APM is based on ddtrace.

## APM Trace Collection Optimization

To achieve the above view effects, you need to make some minor adjustments to your application and DataKit configurations.<br />
The idea behind achieving the above view is as follows:

- When starting the application (microservice), add a tag (instrumentation) `app_id` with the value set to projectId (you can generate a 32-character UUID as the projectId).

- Prepare two `app_id`s: `4a10ede2a69f11eca952fa163e23efe1` (Project A) and `aea5a70da66811eca952fa163e23efe1` (Project B).

### Optimizing Microservices Application YAML

Assuming your application is deployed on K8s,

- The relevant YAML configuration for Project A's microservices is as follows:

```yaml
        - name: APP_ID
          value: "4a10ede2a69f11eca952fa163e23efe1"
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=demo-k8s-auth  -Ddd.tags=container_host:$(POD_NAME),app_id:$(APP_ID) -Ddd.service.mapping=redis:redisk8s -Ddd.env=dev -Ddd.agent.port=9529
```

- The relevant YAML configuration for Project B's microservices is as follows:

```yaml
        - name: APP_ID
          value: "aea5a70da66811eca952fa163e23efe1"
        - name: JAVA_OPTS
          value: |-
            -javaagent:/usr/dd-java-agent/agent/dd-java-agent.jar -Ddd.service.name=k8sruoyi-auth  -Ddd.tags=container_host:$(POD_NAME),app_id:$(APP_ID) -Ddd.service.mapping=redis:redisk8s -Ddd.env=$(SPRING_BOOT_PROFILE) -Ddd.agent.port=9529
```

### Optimizing DataKit YAML

#### Adding ddtrace.conf to ConfigMap

```yaml
    ddtrace.conf: |-
        [[inputs.ddtrace]]
          endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
          customer_tags = ["app_id"]

```

Here, a `customer_tags` label is defined, where you configure your tags.

Additionally, add a mountPath:

```yaml
        - mountPath: /usr/local/datakit/conf.d/ddtrace/ddtrace.conf
          name: datakit-conf
          subPath: ddtrace.conf 
```

#### Disabling Nacos Registration Center Traces

If your application uses a registration center like Nacos, heartbeats from the registration center can generate traces, which may waste resources in actual production environments. If you want to ignore traces related to the registration center, you can do the following:

(If you don't mind, you can skip this step.)

```yaml
    ddtrace.conf: |-
        [[inputs.ddtrace]]
          endpoints = ["/v0.3/traces", "/v0.4/traces", "/v0.5/traces"]
          customer_tags = ["app_id"]
            [inputs.ddtrace.close_resource]
               "*" = ["PUT /nacos/*","GET /nacos/*","POST /nacos/*"]

```

> The Nacos registration center heartbeat reporting mainly uses three URLs, filtered here using regular expressions:<br />
` GET /nacos/v1/ns/instance/list`, `PUT /nacos/v1/ns/instance/beat`, `POST /nacos/v1/cs/configs/listener`.

Restart DataKit and the application. At this point, the optimization configuration is basically complete; go ahead and check the effect.

## More Documentation
<[ddtrace Configuration](../../integrations/ddtrace.md)>

<[Kubernetes Application RUM-APM-LOG Joint Analysis](../cloud-native/k8s-rum-apm-log.md)>