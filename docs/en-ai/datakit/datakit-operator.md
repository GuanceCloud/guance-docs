# Datakit Operator

---

:material-kubernetes:

---

## Overview and Installation {#datakit-operator-overview-and-install}

Datakit Operator is a collaborative project of Datakit within Kubernetes orchestration, designed to assist in the easier deployment of Datakit as well as other features such as validation and injection.

Currently, Datakit-Operator provides the following functionalities:

- Injecting DDTrace SDK (Java/Python/Node.js) along with corresponding environment variable information, refer to [documentation](datakit-operator.md#datakit-operator-inject-lib)
- Injecting Sidecar logfwd service for collecting container logs, refer to [documentation](datakit-operator.md#datakit-operator-inject-logfwd)
- Supporting task elections for Datakit collectors, refer to [documentation](election.md#plugins-election)

Prerequisites:

- It is recommended to use Kubernetes v1.24.1 or higher, with internet access (to download YAML files and pull corresponding images).
- Ensure that `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` [controllers](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites){:target="_blank"} are enabled.
- Ensure that the `admissionregistration.k8s.io/v1` API is enabled.

### Installation Steps {#datakit-operator-install}

<!-- markdownlint-disable MD046 -->
=== "Deployment"

    Download [*datakit-operator.yaml*](https://static.guance.com/datakit-operator/datakit-operator.yaml){:target="_blank"}, follow these steps:
    
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

    To check the deployment status:

    ```shell
    $ helm -n datakit list
    ```

    You can upgrade using the following command:

    ```shell
    $ helm -n datakit get values datakit-operator -a -o yaml > values.yaml
    $ helm upgrade datakit-operator datakit-operator \
        --repo https://pubrepo.guance.com/chartrepo/datakit-operator \
        -n datakit \
        -f values.yaml
    ```

    You can uninstall using the following command:

    ```shell
    $ helm uninstall datakit-operator -n datakit
    ```
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ attention

    - Datakit-Operator has strict correspondence between the program and YAML. Using an outdated YAML might fail to install a new version of Datakit-Operator; please download the latest YAML.
    - If you encounter an `InvalidImageName` error, you can manually pull the image.
<!-- markdownlint-enable -->

## Configuration Explanation {#datakit-operator-jsonconfig}

[:octicons-tag-24: Version-1.4.2](changelog.md#cl-1.4.2)

The configuration for Datakit Operator is in JSON format, stored separately as a ConfigMap in Kubernetes and loaded into the container via environment variables.

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
            "options": {
                "reuse_exist_volume": "false"
            },
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
    }
}
```

The main configuration items are `ddtrace`, `logfwd`, and `profiler`, which specify the injected images and environment variables. Additionally, ddtrace supports batch injection based on `enabled_namespaces` and `enabled_selectors`; see the subsequent section on "Injection Methods".

### Specifying Image Addresses {#datakit-operator-config-images}

Datakit Operator primarily injects images and environment variables, using the `images` configuration to specify image addresses. The `images` configuration consists of multiple Key/Value pairs, where the Key is fixed, and the Value specifies the image address.

Under normal circumstances, images are stored uniformly at `pubrepo.guance.com/datakit-operator`. For special environments that cannot conveniently access this image repository, you can use the following method (using the `dd-lib-java-init` image as an example):

1. In an environment that can access `pubrepo.guance.com`, pull the image `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance` and transfer it to your own image repository, for instance, `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`.
2. Modify the JSON configuration to change `admission_inject`->`ddtrace`->`images`->`java_agent_image` to `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`, and apply this YAML.
3. Thereafter, Datakit Operator will use the new Java Agent image path.

**Datakit Operator does not verify images. If the image path is incorrect, Kubernetes will report an error when creating the Pod.**

### Adding Environment Variables {#datakit-operator-config-envs}

All environment variables that need to be injected must be specified in the configuration file. Datakit Operator does not add any environment variables by default.

The environment variable configuration item is `envs`, consisting of multiple Key/Value pairs: the Key is a fixed value; the Value can be a fixed value or a placeholder, determined according to actual conditions.

For example, adding a `testing-env` in `envs`:

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

All containers injecting the `ddtrace` agent will have the three environment variables from `envs`.

In Datakit Operator v1.4.2 and later versions, `envs` supports Kubernetes Downward API's [environment variable field references](https://kubernetes.io/docs/concepts/workloads/pods/downward-api/#downwardapi-fieldRef). Currently supported fields include:

- `metadata.name`: Pod name
- `metadata.namespace`: Pod namespace
- `metadata.uid`: Unique ID of the Pod
- `metadata.annotations['<KEY>']`: Value of annotation `<KEY>` in the Pod (e.g., `metadata.annotations['myannotation']`)
- `metadata.labels['<KEY>']`: Value of label `<KEY>` in the Pod (e.g., `metadata.labels['mylabel']`)
- `spec.serviceAccountName`: Service account name of the Pod
- `spec.nodeName`: Node name where the Pod runs
- `status.hostIP`: Main IP address of the node where the Pod resides
- `status.hostIPs`: This set of IP addresses is the dual-stack version of `status.hostIP`, with the first IP always matching `status.hostIP`. This field is available when the PodHostIPs feature gate is enabled.
- `status.podIP`: Main IP address of the Pod (usually its IPv4 address)
- `status.podIPs`: This set of IP addresses is the dual-stack version of `status.podIP`, with the first IP always matching `status.podIP`.

For example, if there is a Pod named `nginx-123` in the `middleware` namespace and you want to inject environment variables `POD_NAME` and `POD_NAMESPACE`, you can refer to the following:

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

Ultimately, in this Pod, you would see:

``` shell
$ env | grep POD
POD_NAME=nginx-123
POD_NAMESPACE=middleware
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If the placeholder Value is unrecognizable, it will be added to the environment variable as a plain string. For example, `"POD_NAME": "{fieldRef:metadata.PODNAME}"` is an incorrect usage, resulting in the environment variable `POD_NAME={fieldRef:metadata.PODNAME}`.
<!-- markdownlint-enable -->

## Injection Methods {#datakit-operator-inject}

Datakit-Operator supports two resource input methods: "global namespaces and selectors" and adding specific Annotations to target Pods. The differences are as follows:

- Global configuration of namespaces and selectors: By modifying the Datakit-Operator config, specify the Namespace and Selector of the target Pods. If a Pod matches the criteria, resources are injected.
    - **Advantages**: No need to add Annotations to target Pods (but requires restarting the target Pods).
    - **Disadvantages**: Not precise enough, leading to potential invalid injections.

- Adding Annotations to target Pods: Add Annotations to the target Pods. Datakit-Operator checks the Pod Annotations and injects resources if they match.
    - **Advantages**: Precise scope, no invalid injections.
    - **Disadvantages**: Must add Annotations to the target Pods and restart them.

<!-- markdownlint-disable MD046 -->
???+ attention

    As of Datakit-Operator v1.5.8, the global configuration of namespaces and selectors only works for injecting DDtrace, while logfwd and profiler still require adding annotations for injection.
<!-- markdownlint-enable -->


<!-- markdownlint-disable MD013 -->
### Global Configuration of Namespaces and Selectors {#datakit-operator-config-ddtrace-enabled}
<!-- markdownlint-enable -->

`enabled_namespaces` and `enabled_labelselectors` are specific to `ddtrace`. They are object arrays that need to specify `namespace` and `language`. The relationship between array elements is "OR", written as follows (see the configuration explanation below):

```json
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": {
            "enabled_namespaces": [
                {
                    "namespace": "testns",  # Specify namespace
                    "language": "java"      # Specify the language of the agent to inject
                }
            ],
            "enabled_labelselectors": [
                {
                    "labelselector": "app=log-output",  # Specify labelselector
                    "language": "java"                  # Specify the language of the agent to inject
                }
            ]
            # other..
        }
    }
}
```

If a Pod meets both `enabled_namespaces` and `enabled_labelselectors`, the `enabled_labelselectors` configuration takes precedence (usually used in `language` value).

For the writing rules of labelselectors, refer to the [official documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors){:target="_blank"}.

<!-- markdownlint-disable MD046 -->
???+ note

    - In Kubernetes 1.16.9 or earlier, Admission does not record the Pod Namespace, so the `enabled_namespaces` feature cannot be used.
<!-- markdownlint-enable -->

### Adding Annotation Configuration for Injection {#datakit-operator-config-annotation}

Add specific Annotations to the Deployment to indicate the need to inject `ddtrace` files. Note that Annotations should be added in the template.

The format is:

- Key is `admission.datakit/%s-lib.version`, where `%s` needs to be replaced with the specified language, currently supporting `java`
- Value is the specified version number. Default is the version specified in the Datakit-Operator configuration `java_agent_image`

For example, adding Annotations as follows:

```yaml
      annotations:
        admission.datakit/java-lib.version: "v1.36.2-guance"
```

This indicates that the Pod needs to inject the image version `v1.36.2-guance`, taking the image address from the configuration `admission_inject`->`ddtrace`->`images`->`java_agent_image`, replacing the image version with "v1.36.2-guance", i.e., `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.36.2-guance`.

## Datakit Operator Injection {#datakit-operator-inject-sidecar}

In large Kubernetes clusters, batch-modifying configurations can be cumbersome. Datakit-Operator decides whether to modify or inject based on the Annotation configuration.

Currently supported functionalities include:

- Injecting `ddtrace` agent and environment functionality
- Mounting `logfwd` sidecar and enabling log collection functionality
- Injecting [`async-profiler`](https://github.com/async-profiler/async-profiler){:target="_blank"} to collect profile data from JVM programs [:octicons-beaker-24: Experimental](index.md#experimental)
- Injecting [`py-spy`](https://github.com/benfred/py-spy){:target="_blank"} to collect profile data from Python applications [:octicons-beaker-24: Experimental](index.md#experimental)

<!-- markdownlint-disable MD046 -->
???+ info

    Only supports v1 versions of `deployments/daemonsets/cronjobs/jobs/statefulsets`, and because Datakit-Operator actually operates on PodTemplate, it does not support Pods. In this document, `Deployment` is used to describe these five kinds.
<!-- markdownlint-enable -->

### DDtrace Agent {#datakit-operator-inject-lib}

#### Usage Instructions {#datakit-operator-inject-lib-usage}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation `admission.datakit/java-lib.version: ""` to the deployment, indicating the need to inject the default version of the DDtrace Java Agent.

#### Example {#datakit-operator-inject-lib-example}

Below is a Deployment example that injects `dd-java-lib` into all Pods created by the Deployment:

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

Create resources using the YAML file:

```shell
$ kubectl apply -f nginx.yaml
...
```

Verification:

```shell
$ kubectl get pod

NAME                                   READY   STATUS    RESTARTS      AGE
nginx-deployment-7bd8dd85f-fzmt2       1/1     Running   0             4s

$ kubectl get pod nginx-deployment-7bd8dd85f-fzmt2 -o=jsonpath={.spec.initContainers\[\*\].name}

datakit-lib-init
```

### logfwd {#datakit-operator-inject-logfwd}

#### Prerequisites {#datakit-operator-inject-logfwd-prerequisites}

[logfwd](../integrations/logfwd.md#using) is a dedicated log collection application for Datakit. First, deploy Datakit in the same Kubernetes cluster and meet the following two points:

1. Enable the `logfwdserver` collector in Datakit, e.g., listening on port `9533`
2. Open port `9533` for the Datakit service to allow other Pods to access `datakit-service.datakit.svc:9533`

#### Usage Instructions {#datakit-operator-inject-logfwd-instructions}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation to the deployment, indicating the need to mount the logfwd sidecar. Note that Annotations should be added in the template
    - Key is consistently `admission.datakit/logfwd.instances`
    - Value is a JSON string, specifying the logfwd configuration, as shown below:

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

Parameter explanations, refer to [logfwd configuration](../integrations/logfwd.md#config):

- `datakit_addr` is the Datakit logfwdserver address
- `loggings` is the main configuration, an array. Refer to [Datakit logging collector](../integrations/logging.md)
    - `logfiles` is a list of log files, absolute paths can be specified, supporting glob rules for batch specification. Absolute paths are recommended.
    - `ignore` filters file paths using glob rules. Files matching any condition will not be collected.
    - `source` is the data source. If empty, defaults to 'default'.
    - `service` adds a tag. If empty, defaults to `$source`.
    - `pipeline` specifies the Pipeline script path. If empty, uses `$source.p`. If `$source.p` does not exist, Pipeline is not used.
    - `character_encoding` specifies the encoding. Incorrect encoding may prevent data viewing. Leave blank if unsure. Supports `utf-8/utf-16le/utf-16be/gbk/gb18030`.
    - `multiline_match` specifies multi-line matching. See [Datakit log multiline configuration](../integrations/logging.md#multiline). Note that JSON format does not support triple single quotes for raw strings, so regular expressions like `^\d{4}` should be escaped to `^\\d{4}`.
    - `tags` adds extra tags, formatted as a JSON map, e.g., `{ "key1":"value1", "key2":"value2" }`.

When injecting logfwd, existing volumes with the same path can be reused to avoid errors due to duplicate volumes. Set `admission_inject`->`logfwd`->`options`->`reuse_exist_volume` to `true`.

For example, if the target Pod has a Volume path `/var/log` and `/var/log` is the directory to be collected:

```yaml
spec:
  container:
    # other...
    volumeMounts:
    - name: volume-log
      mountPath: /var/log
  volumes:
  - name: volume-log
    emptyDir: {}
```

If `reuse_exist_volume` is enabled, no new volume or volumeMount is added, and the current `volume-log` is reused.

<!-- markdownlint-disable MD046 -->
???+ attention

   Paths ending with a slash and without a slash have different meanings. `/var/log` and `/var/log/` are different paths and cannot be reused.
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

Create resources using the YAML file:

```shell
$ kubectl apply -f logging.yaml
...
```

Verification:

```shell
$ kubectl get pod

NAME                                   READY   STATUS    RESTARTS      AGE
logging-deployment-5d48bf9995-vt6bb       1/1     Running   0             4s

$ kubectl get pod logging-deployment-5d48bf9995-vt6bb -o=jsonpath={.spec.containers\[\*\].name}
log-container datakit-logfwd
```

Finally, you can view the collected logs in the Guance log platform.

### async-profiler {#inject-async-profiler}

#### Prerequisites {#async-profiler-prerequisites}

- The cluster has installed [Datakit](https://docs.guance.com/datakit/datakit-daemonset-deploy/){:target="_blank"}.
- Enabled the [profile](https://docs.guance.com/datakit/datakit-daemonset-deploy/#using-k8-env){:target="_blank"} collector.
- The Linux kernel parameter [kernel.perf_event_paranoid](https://www.kernel.org/doc/Documentation/sysctl/kernel.txt){:target="_blank"} is set to 2 or lower.

<!-- markdownlint-disable MD046 -->
???+ note

    `async-profiler` uses the [`perf_events`](https://perf.wiki.kernel.org/index.php/Main_Page){:target="_blank"} tool to capture Linux kernel call stacks, which depends on the appropriate kernel settings for non-privileged processes. You can modify the kernel parameters using the following commands:
    ```shell
    $ sudo sysctl kernel.perf_event_paranoid=1
    $ sudo sysctl kernel.kptr_restrict=0
    # Or
    $ sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
    $ sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
    ```
<!-- markdownlint-enable -->

Add the annotation `admission.datakit/java-profiler.version: "latest"` under the `.spec.template.metadata.annotations` section of your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the configuration file. Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, we'll illustrate this with a `Deployment` resource configuration file named `movies-java`.

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

After a few minutes, you can view the application performance data on the [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page in the Guance console.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, it uses the command `jps -q -J-XX:+PerfDisableSharedMem | head -n 20` to find JVM processes in the container. For performance reasons, it collects data from up to 20 processes.

???+ note

    You can configure the behavior of profiling by modifying the environment variables under `datakit-operator-config` in the `datakit-operator.yaml` configuration file.
    
    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | The scheduling plan for profiling, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, e.g., `*/10 * * * *` | `0 * * * *` (once per hour) |
    | `DK_PROFILE_DURATION` | The duration of each profiling session, in seconds                                                                                                                  | 240 (4 minutes)                 |


???+ note

    If you don't see any data, you can enter the `datakit-profiler` container to check the logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-java-784f4bb8c7-59g6s -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

### py-spy {#inject-py-spy}

#### Prerequisites {#py-spy-prerequisites}

- Currently only supports the official Python interpreter (`CPython`)

Add the annotation `admission.datakit/python-profiler.version: "latest"` under the `.spec.template.metadata.annotations` section of your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the configuration file. Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, we'll illustrate this with a `Deployment` resource configuration file named "movies-python".

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

After a few minutes, you can view the application performance data on the [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page in the Guance console.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, it uses the command `ps -e -o pid,cmd --no-headers | grep -v grep | grep "python" | head -n 20` to find Python processes in the container. For performance reasons, it collects data from up to 20 processes.

???+ note

    You can configure the behavior of profiling by modifying the environment variables under `datakit-operator-config` in the `datakit-operator.yaml` configuration file.

    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | The scheduling plan for profiling, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, e.g., `*/10 * * * *` | `0 * * * *` (once per hour) |
    | `DK_PROFILE_DURATION` | The duration of each profiling session, in seconds                                                                                                                  | 240 (4 minutes)                 |


???+ note

    If you don't see any data, you can enter the `datakit-profiler` container to check the logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-python-78b6cf55f-ptzxf -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

### FAQ {#datakit-operator-faq}

- How do you specify that a certain Pod should not be injected? Add the Annotation `"admission.datakit/enabled": "false"` to the Pod, and no operations will be performed on it. This has the highest priority.

- Datakit-Operator uses Kubernetes Admission Controller functionality for resource injection. For detailed mechanisms, please refer to the [official documentation](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/){:target="_blank"}