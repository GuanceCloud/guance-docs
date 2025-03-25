# Datakit Operator

---

:material-kubernetes:

---

## Overview and Installation {#datakit-operator-overview-and-install}

Datakit Operator is a joint project of Datakit in Kubernetes orchestration, aimed at assisting with more convenient deployment of Datakit, as well as features like validation and injection.

Currently, Datakit-Operator provides the following functionalities:

- Injection of DDTrace SDK (Java/Python/Node.js) along with corresponding environment variable information, see [documentation](datakit-operator.md#datakit-operator-inject-lib)
- Injection of Sidecar logfwd service to collect container logs, see [documentation](datakit-operator.md#datakit-operator-inject-logfwd)
- Support for election tasks of Datakit collectors, see [documentation](election.md#plugins-election)

Prerequisites:

- Recommended Kubernetes v1.24.1 or higher, and access to the internet (download yaml file and pull corresponding images)
- Ensure that `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` [controllers](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites){:target="_blank"} are enabled
- Ensure that the `admissionregistration.k8s.io/v1` API is enabled

### Installation Steps {#datakit-operator-install}

<!-- markdownlint-disable MD046 -->
=== "Deployment"

    Download [*datakit-operator.yaml*](https://static.guance.com/datakit-operator/datakit-operator.yaml){:target="_blank"}, steps as follows:
    
    ``` shell
    $ kubectl create namespace datakit
    $ wget https://static.guance.com/datakit-operator/datakit-operator.yaml
    $ kubectl apply -f datakit-operator.yaml
    $ kubectl get pod -n datakit
    
    NAME                               READY   STATUS    RESTARTS   AGE
    datakit-operator-f948897fb-5w5nm   1/1     Running   0          15s
    ```

=== "Helm"

    Prerequisites

    * Kubernetes >= 1.14
    * Helm >= 3.0+

    ```shell
    $ helm install datakit-operator datakit-operator \
         --repo  https://pubrepo.guance.com/chartrepo/datakit-operator \
         -n datakit --create-namespace
    ```

    Check deployment status:

    ```shell
    $ helm -n datakit list
    ```

    You can upgrade via the following command:

    ```shell
    $ helm -n datakit get values datakit-operator -a -o yaml > values.yaml
    $ helm upgrade datakit-operator datakit-operator \
        --repo https://pubrepo.guance.com/chartrepo/datakit-operator \
        -n datakit \
        -f values.yaml
    ```

    You can uninstall via the following command:

    ```shell
    $ helm uninstall datakit-operator -n datakit
    ```
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ attention

    - Datakit-Operator has a strict correspondence between its procedures and yaml files. Using an outdated yaml file may prevent the installation of the latest version of Datakit-Operator; please download the latest version.
    - If you encounter an `InvalidImageName` error, you can manually pull the image.
<!-- markdownlint-enable -->

## Configuration Description {#datakit-operator-jsonconfig}

[:octicons-tag-24: Version-1.4.2](changelog.md#cl-1.4.2)

The configuration for Datakit Operator is in JSON format, stored separately in Kubernetes as a ConfigMap, and loaded into the container via environment variables.

Default configuration:

```json
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": {
            "enabled_namespaces":     [],
            "enabled_labelselectors": [],
            "images": {
                "java_agent_image":   "pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance"
            },
            "envs": {
                "DD_AGENT_HOST":           "datakit-service.datakit.svc",
                "DD_TRACE_AGENT_PORT":     "9529",
                "DD_JMXFETCH_STATSD_HOST": "datakit-service.datakit.svc",
                "DD_JMXFETCH_STATSD_PORT": "8125",
                "DD_SERVICE":              "{fieldRef:metadata.labels['service']}",
                "POD_NAME":                "{fieldRef:metadata.name}",
                "POD_NAMESPACE":           "{fieldRef:metadata.namespace}",
                "NODE_NAME":               "{fieldRef:spec.nodeName}",
                "DD_TAGS":                 "pod_name:$(POD_NAME),pod_namespace:$(POD_NAMESPACE),host:$(NODE_NAME)"
            }
        },
        "logfwd": {
            "images": {
                "logfwd_image": "pubrepo.guance.com/datakit/logfwd:1.28.1"
            }
        },
        "profiler": {
            "images": {
                "java_profiler_image":   "pubrepo.guance.com/datakit-operator/async-profiler:0.1.0",
                "python_profiler_image": "pubrepo.guance.com/datakit-operator/py-spy:0.1.0",
                "golang_profiler_image": "pubrepo.guance.com/datakit-operator/go-pprof:0.1.0"
            },
            "envs": {
                "DK_AGENT_HOST":  "datakit-service.datakit.svc",
                "DK_AGENT_PORT":  "9529",
                "DK_PROFILE_VERSION": "1.2.333",
                "DK_PROFILE_ENV": "prod",
                "DK_PROFILE_DURATION": "240",
                "DK_PROFILE_SCHEDULE": "0 * * * *"
            }
        }
    },
    "admission_mutate": {
        "loggings": [
            {
                "namespace_selectors": ["test01"],
                "label_selectors":     ["app=logging"],
                "config":"[{\"disable\":false,\"type\":\"file\",\"path\":\"/tmp/opt/**/*.log\",\"source\":\"logging-tmp\"},{\"disable\":true,\"type\":\"file\",\"path\":\"/var/log/opt/**/*.log\",\"source\":\"logging-var\"}]"
            }
        ]
    }
}
```

The main configuration items are `ddtrace`, `logfwd`, and `profiler`, which specify injected images and environment variables. Additionally, ddtrace supports batch injection based on `enabled_namespaces` and `enabled_selectors`; see the subsequent section on "Injection Methods."

### Specifying Image Addresses {#datakit-operator-config-images}

The primary role of Datakit Operator is injecting images and environment variables, using the `images` configuration to specify image addresses. The `images` consists of multiple Key/Value pairs, where the keys are fixed, and the values specify the image addresses.

Under normal circumstances, images are uniformly stored in `pubrepo.guance.com/datakit-operator`. For some special environments that cannot conveniently access this image repository, the following method can be used (taking the `dd-lib-java-init` image as an example):

1. In an environment that can access `pubrepo.guance.com`, pull the image `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance` and store it in your own image repository, such as `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`
1. Modify the JSON configuration by changing `admission_inject`->`ddtrace`->`images`->`java_agent_image` to `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`, then apply this yaml.
1. Thereafter, Datakit Operator will use the new Java Agent image path.

**Datakit Operator does not verify images; if the image path is incorrect, Kubernetes will report an error when creating Pods.**

### Adding Environment Variables {#datakit-operator-config-envs}

All required environment variables must be specified in the configuration file; Datakit Operator does not default add any environment variables.

The environment variable configuration item is `envs`, consisting of multiple Key/Value pairs: the key is a fixed value; the value can either be a fixed value or a placeholder, taking actual values according to the situation.

For instance, adding a `testing-env` in `envs`:

```json
{
    "admission_inject": {
        "ddtrace": {
            "envs": {
                "DD_AGENT_HOST":       "datakit-service.datakit.svc",
                "DD_TRACE_AGENT_PORT": "9529",
                "testing-env":         "ok"
            }
        }
    }
}
```

All containers injected with the `ddtrace` agent will have 3 environment variables added from `envs`.

In Datakit Operator v1.4.2 and later versions, `envs` supports Kubernetes Downward API's [environment variable field reference](https://kubernetes.io/zh-cn/docs/concepts/workloads/pods/downward-api/#downwardapi-fieldRef). Currently supported fields include:

- `metadata.name`: Pod name
- `metadata.namespace`: Pod's namespace
- `metadata.uid`: Pod's unique ID
- `metadata.annotations['<KEY>']`: Value of Pod annotation `<KEY>` (e.g., metadata.annotations['myannotation'])
- `metadata.labels['<KEY>']`: Value of Pod label `<KEY>` (e.g., metadata.labels['mylabel'])
- `spec.serviceAccountName`: Name of Pod's service account
- `spec.nodeName`: Name of node where Pod runs
- `status.hostIP`: Main IP address of the node where Pod resides
- `status.hostIPs`: This set of IP addresses represents the dual-stack version of status.hostIP, with the first IP always matching status.hostIP. This field is available after enabling the PodHostIPs feature gate.
- `status.podIP`: Main IP address of the Pod (usually its IPv4 address)
- `status.podIPs`: This set of IP addresses represents the dual-stack version of status.podIP, with the first IP always matching status.podIP.

For example, there is a Pod named nginx-123 in the middleware namespace, and we want to inject environment variables `POD_NAME` and `POD_NAMESPACE`:

```json
{
    "admission_inject": {
        "ddtrace": {
            "envs": {
                "POD_NAME":      "{fieldRef:metadata.name}",
                "POD_NAMESPACE": "{fieldRef:metadata.namespace}"
            }
        }
    }
}
```

Ultimately, within the Pod, you can see:

``` shell
$ env | grep POD
POD_NAME=nginx-123
POD_NAMESPACE=middleware
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If the placeholder for Value cannot be recognized, it will be added to the environment variable as a plain string. For example, `"POD_NAME": "{fieldRef:metadata.PODNAME}"` is an incorrect writing method, resulting in the environment variable being `POD_NAME={fieldRef:metadata.PODNAME}`.
<!-- markdownlint-enable -->

## Injection Methods {#datakit-operator-inject}

Datakit-Operator supports two resource input methods: "global namespaces and selectors configuration" and adding specific Annotations to target Pods. Their differences are as follows:

- Global namespace and selector configuration: By modifying the Datakit-Operator config, specify the Namespace and Selector for target Pods. If a Pod matches the conditions, resources are injected.
    - Advantage: No need to add Annotations to target Pods (but requires restarting target Pods)
    - Disadvantage: Not precise enough, potential for invalid injections

- Adding Annotations to target Pods: Add Annotations to target Pods, Datakit-Operator checks the Pod Annotations and injects if they match.
    - Advantage: Precise range, no invalid injections
    - Disadvantage: Must add Annotations to target Pods, and requires restarting target Pods

<!-- markdownlint-disable MD046 -->
???+ attention

    As of Datakit-Operator v1.5.8, the global namespaces and selectors configuration only works for DDtrace injection, while logfwd and profiler still require adding annotations for injection.
<!-- markdownlint-enable -->


<!-- markdownlint-disable MD013 -->
### Global namespaces and selectors configuration {#datakit-operator-config-ddtrace-enabled}
<!-- markdownlint-enable -->

`enabled_namespaces` and `enabled_labelselectors` are exclusive to `ddtrace`, they are object arrays requiring specification of `namespace` and `language`. The relationship between array elements is "OR", written as follows (see detailed configuration notes below):

```json
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": {
            "enabled_namespaces": [
                {
                    "namespace": "testns",  # Specify namespace
                    "language": "java"      # Specify language for the agent to inject
                }
            ],
            "enabled_labelselectors": [
                {
                    "labelselector": "app=log-output",  # Specify labelselector
                    "language": "java"                  # Specify language for the agent to inject
                }
            ]
            # other..
        }
    }
}
```

If a Pod satisfies both `enabled_namespaces` rules and `enabled_labelselectors`, the configuration of `enabled_labelselectors` takes precedence (usually used in `language` values).

Refer to this [official documentation](https://kubernetes.io/zh-cn/docs/concepts/overview/working-with-objects/labels/#label-selectors){:target="_blank"} for guidelines on writing labelselectors.

<!-- markdownlint-disable MD046 -->
???+ note

    - In Kubernetes 1.16.9 or earlier, Admission does not record Pod Namespace, so the `enabled_namespaces` function cannot be used.
<!-- markdownlint-enable -->

### Adding Annotation Configuration for Injection {#datakit-operator-config-annotation}

Add the specified Annotation to Deployment, indicating the need to inject the `ddtrace` file. Note that the Annotation should be added in the template.

Its format is:

- Key is `admission.datakit/%s-lib.version`, `%s` needs to be replaced with the specified language, currently supporting `java`
- Value specifies the version number. Default is the version specified in Datakit-Operator's `java_agent_image` configuration

For example, add the Annotation as follows:

```yaml
      annotations:
        admission.datakit/java-lib.version: "v1.36.2-guance"
```

This indicates that the Pod needs to inject the image version `v1.36.2-guance`, and the image address comes from the configuration `admission_inject`->`ddtrace`->`images`->`java_agent_image`, replacing the image version with "v1.36.2-guance", i.e., `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.36.2-guance`.

## Datakit Operator Injection {#datakit-operator-inject-sidecar}

In large Kubernetes clusters, batch modification of configurations can be cumbersome. Datakit-Operator decides whether to modify or inject based on the Annotation configuration.

Currently supported functions include:

- Injection of `ddtrace` agent and environment functionality
- Mounting of `logfwd` sidecar and enabling log collection functionality
- Injection of [`async-profiler`](https://github.com/async-profiler/async-profiler){:target="_blank"} to collect JVM program profile data [:octicons-beaker-24: Experimental](index.md#experimental)
- Injection of [`py-spy`](https://github.com/benfred/py-spy){:target="_blank"} to collect Python application profile data [:octicons-beaker-24: Experimental](index.md#experimental)

<!-- markdownlint-disable MD046 -->
???+ info

    Only supports v1 versions of `deployments/daemonsets/cronjobs/jobs/statefulsets` these five kinds of Kind, and because Datakit-Operator actually operates on PodTemplate, it does not support Pod. In this article, `Deployment` is used to describe these five kinds of Kind.
<!-- markdownlint-enable -->

### DDtrace Agent {#datakit-operator-inject-lib}

#### Usage Instructions {#datakit-operator-inject-lib-usage}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation `admission.datakit/java-lib.version: ""` to the deployment, indicating the need to inject the default version of DDtrace Java Agent.

#### Example {#datakit-operator-inject-lib-example}

Below is a Deployment example, injecting `dd-java-lib` into all Pods created by the Deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
      annotations:
        admission.datakit/java-lib.version: ""
    spec:
      containers:
      - name: nginx
        image: nginx:1.22
        ports:
        - containerPort: 80
```

Create resources using the yaml file:

```shell
$ kubectl apply -f nginx.yaml
...
```

Verify as follows:

```shell
$ kubectl get pod

NAME                                   READY   STATUS    RESTARTS      AGE
nginx-deployment-7bd8dd85f-fzmt2       1/1     Running   0             4s

$ kubectl get pod nginx-deployment-7bd8dd85f-fzmt2 -o=jsonpath={.spec.initContainers\[\*\].name}

datakit-lib-init
```

### logfwd {#datakit-operator-inject-logfwd}

#### Prerequisites {#datakit-operator-inject-logfwd-prerequisites}

[logfwd](../integrations/logfwd.md#using) is a dedicated log collection application for Datakit, requiring prior deployment of Datakit in the same Kubernetes cluster, and achieving the following two points:

1. Datakit enables the `logfwdserver` collector, for example, listening on port `9533`
2. Datakit service needs to expose port `9533`, allowing other Pods to access `datakit-service.datakit.svc:9533`

#### Usage Instructions {#datakit-operator-inject-logfwd-instructions}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation to the deployment, indicating the need to mount the logfwd sidecar. Note that the Annotation must be added in the template
    - Key is unified as `admission.datakit/logfwd.instances`
    - Value is a JSON string specifying the logfwd configuration, as shown below:

``` json
[
    {
        "datakit_addr": "datakit-service.datakit.svc:9533",
        "loggings": [
            {
                "logfiles": ["<your-logfile-path>"],
                "ignore": [],
                "source": "<your-source>",
                "service": "<your-service>",
                "pipeline": "<your-pipeline.p>",
                "character_encoding": "",
                "multiline_match": "<your-match>",
                "tags": {}
            },
            {
                "logfiles": ["<your-logfile-path-2>"],
                "source": "<your-source-2>"
            }
        ]
    }
]
```

Parameter description, refer to [logfwd configuration](../integrations/logfwd.md#config):

- `datakit_addr` is the Datakit logfwdserver address
- `loggings` is the main configuration, an array, refer to [Datakit logging collector](../integrations/logging.md)
    - `logfiles` list of log files, absolute paths can be specified, supports glob rules for bulk designation, recommend using absolute paths
    - `ignore` file path filtering, uses glob rules, files matching any condition will not be collected
    - `source` data source, defaults to 'default' if empty
    - `service` additional tag, defaults to $source if empty
    - `pipeline` Pipeline script path, defaults to $source.p if empty, will not use Pipeline if $source.p does not exist (this script file exists on the DataKit end)
    - `character_encoding` choose encoding, if encoding is wrong it may result in unreadable data, default is empty. Supports `utf-8/utf-16le/utf-16le/gbk/gb18030`
    - `multiline_match` multiline matching, see [Datakit log multiline configuration](../integrations/logging.md#multiline), note that due to JSON format triple single quotes for "non-escaped writing" are not supported, regular expression `^\d{4}` needs to be escaped as `^\\d{4}`
    - `tags` add extra `tag`, written in JSON map format, e.g., `{ "key1":"value1", "key2":"value2" }`

<!-- markdownlint-disable MD046 -->
???+ attention

    When injecting logfwd, Datakit Operator reuses volumes with the same path by default to avoid errors caused by existing identical paths.

    Paths ending with a slash and without a slash have different meanings, for example `/var/log` and `/var/log/` are different paths and cannot be reused.
<!-- markdownlint-enable -->

#### Example {#datakit-operator-inject-logfwd-example}

Below is a Deployment example that continuously writes data to a file and configures the collection of that file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: logging-deployment
  labels:
    app: logging
spec:
  replicas: 1
  selector:
    matchLabels:
      app: logging
  template:
    metadata:
      labels:
        app: logging
      annotations:
        admission.datakit/logfwd.instances: '[{"datakit_addr":"datakit-service.datakit.svc:9533","loggings":[{"logfiles":["/var/log/log-test/*.log"],"source":"deployment-logging","tags":{"key01":"value01"}}]}]'
    spec:
      containers:
      - name: log-container
        image: busybox
        args: [/bin/sh, -c, 'mkdir -p /var/log/log-test; i=0; while true; do printf "$(date "+%F %H:%M:%S") [%-8d] Bash For Loop Examples.\\n" $i >> /var/log/log-test/1.log; i=$((i+1)); sleep 1; done']
```

Create resources using the yaml file:

```shell
$ kubectl apply -f logging.yaml
...
```

Verify as follows:

```shell
$ kubectl get pod

NAME                                   READY   STATUS    RESTARTS      AGE
logging-deployment-5d48bf9995-vt6bb       1/1     Running   0             4s

$ kubectl get pod logging-deployment-5d48bf9995-vt6bb -o=jsonpath={.spec.containers\[\*\].name}
log-container datakit-logfwd
```

Finally, check if the logs are collected on the Guance log platform.

### async-profiler {#inject-async-profiler}

#### Prerequisites {#async-profiler-prerequisites}

- The cluster has installed [Datakit](https://docs.guance.com/datakit/datakit-daemonset-deploy/){:target="_blank"}.
- Enable the [profile](https://docs.guance.com/datakit/datakit-daemonset-deploy/#using-k8-env){:target="_blank"} collector.
- Linux kernel parameter [kernel.perf_event_paranoid](https://www.kernel.org/doc/Documentation/sysctl/kernel.txt){:target="_blank"} value is set to 2 or lower.

<!-- markdownlint-disable MD046 -->
???+ note

    `async-profiler` uses [`perf_events`](https://perf.wiki.kernel.org/index.php/Main_Page){:target="_blank"} tools to capture Linux kernel call stacks, non-privileged processes depend on corresponding kernel settings, you can modify the kernel parameters using the following commands:
    ```shell
    $ sudo sysctl kernel.perf_event_paranoid=1
    $ sudo sysctl kernel.kptr_restrict=0
    # Or
    $ sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
    $ sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
    ```
<!-- markdownlint-enable -->

Add the annotation `admission.datakit/java-profiler.version: "latest"` under the `.spec.template.metadata.annotations` node in your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the configuration file,
Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, an example is provided using a `Deployment` resource configuration file named `movies-java`.

```yaml
kind: Deployment
metadata:
  name: movies-java
  labels:
    app: movies-java
spec:
  replicas: 1
  selector:
    matchLabels:
      app: movies-java
  template:
    metadata:
      name: movies-java
      labels:
        app: movies-java
      annotations:
        admission.datakit/java-profiler.version: "0.4.4"
    spec:
      containers:
        - name: movies-java
          image: zhangyicloud/movies-java:latest
          imagePullPolicy: IfNotPresent
          securityContext:
            seccompProfile:
              type: Unconfined
          env:
            - name: JAVA_OPTS
              value: ""

      restartPolicy: Always
```

Apply the configuration file and check if it takes effect:

```shell
$ kubectl apply -f deployment-movies-java.yaml

$ kubectl get pods | grep movies-java
movies-java-784f4bb8c7-59g6s   2/2     Running   0          47s

$ kubectl describe pod movies-java-784f4bb8c7-59g6s | grep datakit-profiler
      /app/datakit-profiler from datakit-profiler-volume (rw)
  datakit-profiler:
      /app/datakit-profiler from datakit-profiler-volume (rw)
  datakit-profiler-volume:
  Normal  Created    12m   kubelet            Created container datakit-profiler
  Normal  Started    12m   kubelet            Started container datakit-profiler
```

After a few minutes, you can view the application performance data on the Guance console [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, the command `jps -q -J-XX:+PerfDisableSharedMem | head -n 20` is used to find JVM processes in the container. For performance reasons, data from a maximum of 20 processes will be collected.

???+ note

    You can configure the behavior of profiling by modifying the environment variables under `datakit-operator-config` in the `datakit-operator.yaml` configuration file.
    
    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | The scheduling plan for profiling, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, such as `*/10 * * * *` | `0 * * * *` (scheduled once per hour) |
    | `DK_PROFILE_DURATION` | Duration of each profiling session, in seconds                                                                                                                  | 240 (4 minutes)                 |


???+ note

    If no data is visible, enter the `datakit-profiler` container to check the corresponding logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-java-784f4bb8c7-59g6s -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

### py-spy {#inject-py-spy}

#### Prerequisites {#py-spy-prerequisites}

- Currently only supports the official Python interpreter (`CPython`)

Add the annotation `admission.datakit/python-profiler.version: "latest"` under the `.spec.template.metadata.annotations` node in your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the configuration file,
Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, an example is provided using a `Deployment` resource configuration file named "movies-python".

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: movies-python
  labels:
    app: movies-python
spec:
  replicas: 1
  selector:
    matchLabels:
      app: movies-python
  template:
    metadata:
      name: movies-python
      labels:
        app: movies-python
      annotations:
        admission.datakit/python-profiler.version: "latest"
    spec:
      containers:
        - name: movies-python
          image: zhangyicloud/movies-python:latest
          imagePullPolicy: Always
          command:
            - "gunicorn"
            - "-w"
            - "4"
            - "--bind"
            - "0.0.0.0:8080"
            - "app:app"
```

Apply the configuration file and verify if it takes effect:

```shell
$ kubectl apply -f deployment-movies-python.yaml

$ kubectl get pods | grep movies-python
movies-python-78b6cf55f-ptzxf   2/2     Running   0          64s
 
$ kubectl describe pod movies-python-78b6cf55f-ptzxf | grep datakit-profiler
      /app/datakit-profiler from datakit-profiler-volume (rw)
  datakit-profiler:
      /app/datakit-profiler from datakit-profiler-volume (rw)
  datakit-profiler-volume:
  Normal  Created    98s   kubelet            Created container datakit-profiler
  Normal  Started    97s   kubelet            Started container datakit-profiler
```

After a few minutes, you can view the application performance data on the Guance console [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, the command `ps -e -o pid,cmd --no-headers | grep -v grep | grep "python" | head -n 20` is used to find `Python` processes in the container. For performance reasons, data from a maximum of 20 processes will be collected.

???+ note

    You can configure the behavior of profiling by modifying the environment variables under the ConfigMap `datakit-operator-config` in the `datakit-operator.yaml` configuration file.

    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | The scheduling plan for profiling, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, such as `*/10 * * * *` | `0 * * * *` (scheduled once per hour) |
    | `DK_PROFILE_DURATION` | Duration of each profiling session, in seconds                                                                                                                  | 240 (4 minutes)                 |


???+ note

    If no data is visible, enter the `datakit-profiler` container to check the corresponding logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-python-78b6cf55f-ptzxf -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

## Datakit Operator Resource Changes {#datakit-operator-mutate-resource}

### Adding Configurations Required for Datakit Logging Collection {#add-logging-configs}

Datakit Operator can automatically add the configurations required for Datakit Logging collection to specified Pods, including `datakit/logs` annotations and corresponding file path volume/volumeMount, simplifying manual configuration steps. Thus, users do not need to manually intervene in each Pod configuration to enable automatic log collection functionality.

Below is an example configuration showing how to automatically inject log collection configurations through the `admission_mutate` configuration of Datakit Operator:

```json
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        # Other configurations
    },
    "admission_mutate": {
        "loggings": [
            {
                "namespace_selectors": ["middleware"],
                "label_selectors":     ["app=logging"],
                "config": "[{\"disable\":false,\"type\":\"file\",\"path\":\"/tmp/opt/**/*.log\",\"source\":\"logging-tmp\"}]"
            }
        ]
    }
}
```

`admission_mutate.loggings`: This is an array of objects containing multiple log collection configurations. Each log configuration includes the following fields:

- `namespace_selectors`: Limits the Namespaces of Pods that meet the conditions. Multiple Namespaces can be set; Pods must match at least one Namespace to be selected. It has an "OR" relationship with `label_selectors`.
- `label_selectors`: Limits the labels of Pods that meet the conditions. Pods must match at least one label selector to be selected. It has an "OR" relationship with `namespace_selectors`.
- `config`: This is a JSON string that will be added to the Pod's annotations, with the Key being `datakit/logs`. If the Key already exists, it will not be overwritten or duplicated. This configuration tells Datakit how to collect logs.

Datakit Operator will automatically parse the `config` configuration and create corresponding volumes and volumeMounts for the Pod based on the paths (`path`) in it.

Using the above Datakit Operator configuration as an example, if a Pod's Namespace is `middleware` or Labels match `app=logging`, annotations and mounts will be added to the Pod. For example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    datakit/logs: '[{"disable":false,"type":"file","path":"/tmp/opt/**/*.log","source":"logging-tmp"}]'
  labels:
    app: logging
  name: logging-test
  namespace: default
spec:
  containers:
  - args:
    - |
      mkdir -p /tmp/opt/log1;
      i=1;
      while true; do
        echo "Writing logs to file ${i}.log";
        for ((j=1;j<=10000000;j++)); do
          echo "$(date +'%F %H:%M:%S')  [$j]  Bash For Loop Examples. Hello, world! Testing output." >> /tmp/opt/log1/file_${i}.log;
          sleep 1;
        done;
        echo "Finished writing 5000000 lines to file_${i}.log";
        i=$((i+1));
      done
    command:
    - /bin/bash
    - -c
    - --
    image: pubrepo.guance.com/base/ubuntu:18.04
    imagePullPolicy: IfNotPresent
    name: demo
    volumeMounts:
    - mountPath: /tmp/opt
      name: datakit-logs-volume-0
  volumes:
  - emptyDir: {}
    name: datakit-logs-volume-0
```

This Pod has the label `app=logging`, which matches, so Datakit Operator adds the `datakit/logs` annotation and mounts the path `/tmp/opt` as an EmptyDir.

Once Datakit detects the Pod, it will customize log collection based on the content of `datakit/logs`.

### FAQ {#datakit-operator-faq}

- How to specify that a certain Pod should not be injected? Add the Annotation `"admission.datakit/enabled": "false"` to the Pod, and no operations will be performed on it, this has the highest priority.

- Datakit-Operator uses the Kubernetes Admission Controller feature for resource injection; for detailed mechanisms, please see the [official documentation](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/admission-controllers/){:target="_blank"}