# Datakit Operator

---

:material-kubernetes:

---

## Overview and Installation {#datakit-operator-overview-and-install}

Datakit Operator is a collaborative project of Datakit orchestrated in Kubernetes, aimed at assisting with easier deployment of Datakit, as well as functionalities such as validation and injection.

Currently, Datakit-Operator provides the following features:

- Inject DDTrace SDK (Java/Python/Node.js) along with corresponding environment variable information; see [documentation](datakit-operator.md#datakit-operator-inject-lib)
- Inject Sidecar logfwd service to collect logs within containers; see [documentation](datakit-operator.md#datakit-operator-inject-logfwd)
- Support election for Datakit collector tasks; see [documentation](election.md#plugins-election)

Prerequisites:

- It is recommended to use Kubernetes v1.24.1 or higher, with internet access (to download YAML files and pull corresponding images)
- Ensure that `MutatingAdmissionWebhook` and `ValidatingAdmissionWebhook` [controllers](https://kubernetes.io/en/docs/reference/access-authn-authz/extensible-admission-controllers/#prerequisites){:target="_blank"} are enabled
- Ensure that the `admissionregistration.k8s.io/v1` API is enabled

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

    Check deployment status:

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

    - Datakit-Operator has strict correspondence between its program and YAML. Using an outdated YAML may prevent the installation of a new version of Datakit-Operator. Please download the latest YAML.
    - If you encounter an `InvalidImageName` error, you can manually pull the image.
<!-- markdownlint-enable -->

## Configuration Explanation {#datakit-operator-jsonconfig}

[:octicons-tag-24: Version-1.4.2](changelog.md#cl-1.4.2)

Datakit Operator configuration is in JSON format, stored separately as a ConfigMap in Kubernetes, and loaded into the container as environment variables.

Default configuration is as follows:

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

The main configuration items are `ddtrace`, `logfwd`, and `profiler`, specifying injected images and environment variables. Additionally, `ddtrace` supports batch injection based on `enabled_namespaces` and `enabled_selectors`; see the later section on "Injection Methods".

### Specifying Image Addresses {#datakit-operator-config-images}

Datakit Operator mainly injects images and environment variables, using `images` to configure image addresses. `images` consists of multiple Key/Value pairs, where the Keys are fixed, and modifying the Value specifies the image address.

Under normal circumstances, images are uniformly stored in `pubrepo.guance.com/datakit-operator`. For special environments where this image repository is not easily accessible, you can use the following method (using the `dd-lib-java-init` image as an example):

1. In an environment that can access `pubrepo.guance.com`, pull the image `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.30.1-guance` and store it in your own image repository, for example, `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`
1. Modify the JSON configuration by changing `admission_inject`->`ddtrace`->`images`->`java_agent_image` to `inside.image.hub/datakit-operator/dd-lib-java-init:v1.30.1-guance`, then apply this YAML
1. Thereafter, Datakit Operator will use the new Java Agent image path

**Datakit Operator does not check images. If the image path is incorrect, Kubernetes will report an error when creating Pods.**

### Adding Environment Variables {#datakit-operator-config-envs}

All environment variables that need to be injected must be specified in the configuration file. Datakit Operator does not add any environment variables by default.

Environment variables are configured under the `envs` section, which consists of multiple Key/Value pairs: Keys are fixed values; Values can be fixed values or placeholders, which take actual values based on the context.

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

All containers that inject the `ddtrace` agent will have three environment variables added from `envs`.

Starting from Datakit Operator v1.4.2, `envs` supports Kubernetes Downward API's [environment variable field references](https://kubernetes.io/en/docs/concepts/workloads/pods/downward-api/#downwardapi-fieldRef). The supported fields include:

- `metadata.name`: Pod name
- `metadata.namespace`: Pod namespace
- `metadata.uid`: Unique ID of the Pod
- `metadata.annotations['<KEY>']`: Value of annotation `<KEY>` in the Pod (e.g., `metadata.annotations['myannotation']`)
- `metadata.labels['<KEY>']`: Value of label `<KEY>` in the Pod (e.g., `metadata.labels['mylabel']`)
- `spec.serviceAccountName`: Service account name of the Pod
- `spec.nodeName`: Node name where the Pod runs
- `status.hostIP`: Main IP address of the node where the Pod resides
- `status.hostIPs`: This set of IP addresses is the dual-stack version of `status.hostIP`, with the first IP always matching `status.hostIP`. This field is available when the `PodHostIPs` feature gate is enabled.
- `status.podIP`: Main IP address of the Pod (usually its IPv4 address)
- `status.podIPs`: This set of IP addresses is the dual-stack version of `status.podIP`, with the first IP always matching `status.podIP`.

For example, if there is a Pod named `nginx-123` in the `middleware` namespace, and you want to inject environment variables `POD_NAME` and `POD_NAMESPACE`, refer to the following:

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

Finally, in the Pod, you can see:

``` shell
$ env | grep POD
POD_NAME=nginx-123
POD_NAMESPACE=middleware
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If the placeholder cannot be recognized, it will be added to the environment variable as a plain string. For example, `"POD_NAME": "{fieldRef:metadata.PODNAME}"` is incorrect, and the environment variable will be `POD_NAME={fieldRef:metadata.PODNAME}`.
<!-- markdownlint-enable -->

## Injection Methods {#datakit-operator-inject}

Datakit-Operator supports two resource input methods: "global configuration of namespaces and selectors" and adding specific Annotations to target Pods. Their differences are as follows:

- Global configuration of namespaces and selectors: By modifying the Datakit-Operator config, specify the Namespace and Selector of the target Pods. If a Pod matches the conditions, resources will be injected.
    - Advantage: No need to add Annotations to target Pods (but the target Pods need to be restarted)
    - Disadvantage: Not precise enough, potential invalid injections

- Adding Annotations to target Pods: Add Annotations to the target Pods, and Datakit-Operator will check the Pod Annotations. If they match, resources will be injected.
    - Advantage: Precise range, no invalid injections
    - Disadvantage: Must add Annotations to target Pods, and the target Pods need to be restarted

<!-- markdownlint-disable MD046 -->
???+ attention

    As of Datakit-Operator v1.5.8, global configuration of namespaces and selectors only works for injecting DDtrace, not for logfwd and profiler, which still require adding annotations for injection.
<!-- markdownlint-enable -->


<!-- markdownlint-disable MD013 -->
### Global Configuration of Namespaces and Selectors {#datakit-operator-config-ddtrace-enabled}
<!-- markdownlint-enable -->

`enabled_namespaces` and `enabled_labelselectors` are exclusive to `ddtrace`. They are object arrays that need to specify `namespace` and `language`. Arrays have an "OR" relationship, written as follows (see detailed configuration explanation below):

```json
{
    "server_listen": "0.0.0.0:9543",
    "log_level":     "info",
    "admission_inject": {
        "ddtrace": {
            "enabled_namespaces": [
                {
                    "namespace": "testns",  # Specify namespace
                    "language": "java"      # Specify language of the agent to be injected
                }
            ],
            "enabled_labelselectors": [
                {
                    "labelselector": "app=log-output",  # Specify labelselector
                    "language": "java"                  # Specify language of the agent to be injected
                }
            ]
            # other..
        }
    }
}
```

If a Pod matches both `enabled_namespaces` and `enabled_labelselectors`, the `enabled_labelselectors` configuration takes precedence (especially useful for determining the `language` value).

For writing labelselectors, refer to this [official documentation](https://kubernetes.io/en/docs/concepts/overview/working-with-objects/labels/#label-selectors){:target="_blank"}.

<!-- markdownlint-disable MD046 -->
???+ note

    - In Kubernetes 1.16.9 or earlier, Admission does not record Pod Namespace, so `enabled_namespaces` functionality cannot be used.
<!-- markdownlint-enable -->

### Adding Annotation Configuration for Injection {#datakit-operator-config-annotation}

Add specific Annotations in Deployment to indicate the need to inject `ddtrace` files. Note that Annotations should be added in the template.

Its format is:

- key is `admission.datakit/%s-lib.version`, `%s` needs to be replaced with the specified language, currently supporting `java`
- value is the specified version number. Default is the version specified in the Datakit-Operator configuration `java_agent_image`

For example, adding Annotations as follows:

```yaml
      annotations:
        admission.datakit/java-lib.version: "v1.36.2-guance"
```

This indicates that the Pod requires the image version `v1.36.2-guance`, and the image address is taken from the configuration `admission_inject`->`ddtrace`->`images`->`java_agent_image`, replacing the image version with "v1.36.2-guance", i.e., `pubrepo.guance.com/datakit-operator/dd-lib-java-init:v1.36.2-guance`.

## Datakit Operator Injection {#datakit-operator-inject-sidecar}

In large Kubernetes clusters, batch-modifying configurations can be cumbersome. Datakit-Operator will decide whether to modify or inject based on the Annotation configuration.

Currently supported features include:

- Injecting `ddtrace` agent and environment variables
- Mounting `logfwd` sidecar and enabling log collection
- Injecting [`async-profiler`](https://github.com/async-profiler/async-profiler){:target="_blank"} to collect JVM application profile data [:octicons-beaker-24: Experimental](index.md#experimental)
- Injecting [`py-spy`](https://github.com/benfred/py-spy){:target="_blank"} to collect Python application profile data [:octicons-beaker-24: Experimental](index.md#experimental)

<!-- markdownlint-disable MD046 -->
???+ info

    Only supports v1 versions of `deployments/daemonsets/cronjobs/jobs/statefulsets` these five types of Kind, and because Datakit-Operator actually operates on PodTemplate, it does not support Pod. In this document, `Deployment` represents these five types of Kind.
<!-- markdownlint-enable -->

### DDtrace Agent {#datakit-operator-inject-lib}

#### Usage Instructions {#datakit-operator-inject-lib-usage}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation `admission.datakit/java-lib.version: ""` in the deployment, indicating the need to inject the default version of the DDtrace Java Agent.

#### Example {#datakit-operator-inject-lib-example}

Below is a Deployment example to inject `dd-java-lib` into all Pods created by the Deployment:

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

[logfwd](../integrations/logfwd.md#using) is a dedicated log collection application of Datakit. First, deploy Datakit in the same Kubernetes cluster and ensure the following two points:

1. Datakit enables the `logfwdserver` collector, e.g., listening port is `9533`
2. Datakit service opens port `9533` to allow other Pods to access `datakit-service.datakit.svc:9533`

#### Usage Instructions {#datakit-operator-inject-logfwd-instructions}

1. In the target Kubernetes cluster, [download and install Datakit-Operator](datakit-operator.md#datakit-operator-overview-and-install)
2. Add the specified Annotation in the deployment, indicating the need to mount the logfwd sidecar. Note that the Annotation should be added in the template
    - key is unified as `admission.datakit/logfwd.instances`
    - value is a JSON string, representing specific logfwd configurations, example as follows:

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
- `loggings` is the main configuration, an array, refer to [Datakit logging collector](../integrations/logging.md)
    - `logfiles` is a list of log files, absolute paths can be specified, glob rules can be used for batch designation, absolute paths are recommended
    - `ignore` filters file paths using glob rules, files matching any condition will not be collected
    - `source` is the data source, defaults to 'default' if empty
    - `service` adds a tag, defaults to `$source` if empty
    - `pipeline` is the Pipeline script path, defaults to `$source.p` if empty, and if `$source.p` does not exist, Pipeline will not be used (this script file exists on the DataKit end)
    - `character_encoding` selects encoding, if encoding is incorrect, data may not be viewable. Defaults to empty. Supports `utf-8/utf-16le/utf-16le/gbk/gb18030`
    - `multiline_match` multiline matching, see [Datakit log multiline configuration](../integrations/logging.md#multiline), note that JSON format does not support triple single quotes for "unescaped writing," regular expression `^\d{4}` needs to be escaped as `^\\d{4}`
    - `tags` adds extra `tag`, written as a JSON map, e.g., `{ "key1":"value1", "key2":"value2" }`

<!-- markdownlint-disable MD046 -->
???+ attention

    When injecting logfwd, Datakit Operator reuses volumes with the same path by default to avoid errors due to existing volumes with the same path.

    Paths ending with a slash and without a slash have different meanings, e.g., `/var/log` and `/var/log/` are different paths and cannot be reused.
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

Ultimately, you can view the logs in the Guance log platform.

### async-profiler {#inject-async-profiler}

#### Prerequisites {#async-profiler-prerequisites}

- Cluster has installed [Datakit](https://docs.guance.com/datakit/datakit-daemonset-deploy/){:target="_blank"}.
- Enable the [profile](https://docs.guance.com/datakit/datakit-daemonset-deploy/#using-k8-env){:target="_blank"} collector.
- Linux kernel parameter [kernel.perf_event_paranoid](https://www.kernel.org/doc/Documentation/sysctl/kernel.txt){:target="_blank"} value is set to 2 or lower.

<!-- markdownlint-disable MD046 -->
???+ note

    `async-profiler` uses [`perf_events`](https://perf.wiki.kernel.org/index.php/Main_Page){:target="_blank"} tool to capture Linux kernel call stacks. Non-privileged processes depend on the corresponding kernel settings. Use the following commands to modify kernel parameters:
    ```shell
    $ sudo sysctl kernel.perf_event_paranoid=1
    $ sudo sysctl kernel.kptr_restrict=0
    # or
    $ sudo sh -c 'echo 1 >/proc/sys/kernel/perf_event_paranoid'
    $ sudo sh -c 'echo 0 >/proc/sys/kernel/kptr_restrict'
    ```
<!-- markdownlint-enable -->

Add the annotation `admission.datakit/java-profiler.version: "latest"` under the `.spec.template.metadata.annotations` section of your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the resource configuration file. Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, we will explain using a `Deployment` resource configuration file named `movies-java` as an example.

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

After a few minutes, you can view the application performance data on the [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page of the Guance console.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, the command `jps -q -J-XX:+PerfDisableSharedMem | head -n 20` is used to find JVM processes in the container. For performance reasons, it will only collect data from up to 20 processes.

???+ note

    You can configure profiling behavior by modifying the environment variables under `datakit-operator-config` in the `datakit-operator.yaml` configuration file.
    
    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | Profiling schedule, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, like `*/10 * * * *` | `0 * * * *`（scheduled once per hour） |
    | `DK_PROFILE_DURATION` | Duration of each profiling session, in seconds                                                                                                                  | 240（4 minutes）                 |


???+ note

    If no data appears, you can enter the `datakit-profiler` container to check the corresponding logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-java-784f4bb8c7-59g6s -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

### py-spy {#inject-py-spy}

#### Prerequisites {#py-spy-prerequisites}

- Currently supports only the official Python interpreter (`CPython`)

Add the annotation `admission.datakit/python-profiler.version: "latest"` under the `.spec.template.metadata.annotations` section of your [Pod controller](https://kubernetes.io/docs/concepts/workloads/controllers/){:target="_blank"} resource configuration file, then apply the resource configuration file. Datakit-Operator will automatically create a container named `datakit-profiler` in the corresponding Pod to assist with profiling.

Next, we will explain using a `Deployment` resource configuration file named "movies-python" as an example.

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

Apply the resource configuration and verify if it takes effect:

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

After a few minutes, you can view the application performance data on the [APM Profiling](https://console.guance.com/tracing/profile){:target="_blank"} page of the Guance console.

<!-- markdownlint-disable MD046 -->
???+ note

    By default, the command `ps -e -o pid,cmd --no-headers | grep -v grep | grep "python" | head -n 20` is used to find Python processes in the container. For performance reasons, it will only collect data from up to 20 processes.

???+ note

    You can configure profiling behavior by modifying the environment variables under the ConfigMap `datakit-operator-config` in the `datakit-operator.yaml` configuration file.

    | Environment Variable              | Description                                                                                                                                               | Default Value                        |
    | ----                  | --                                                                                                                                                 | -----                         |
    | `DK_PROFILE_SCHEDULE` | Profiling schedule, using the same syntax as Linux [Crontab](https://man7.org/linux/man-pages/man5/crontab.5.html){:target="_blank"}, like `*/10 * * * *` | `0 * * * *`（scheduled once per hour） |
    | `DK_PROFILE_DURATION` | Duration of each profiling session, in seconds                                                                                                                  | 240（4 minutes）                 |


???+ note

    If no data appears, you can enter the `datakit-profiler` container to check the corresponding logs for troubleshooting:
    ```shell
    $ kubectl exec -it movies-python-78b6cf55f-ptzxf -c datakit-profiler -- bash
    $ tail -n 2000 log/main.log
    ```
<!-- markdownlint-enable -->

When refining the documentation, you can further clarify the meaning of each field and add additional notes to help users better understand the entire process. Here is the improved version:

---

## Datakit Operator Resource Changes {#datakit-operator-mutate-resource}

### Adding Datakit Logging Collection Configuration {#add-logging-configs}

Datakit Operator can automatically add the necessary configuration for Datakit Logging collection to specified Pods, including `datakit/logs` annotations and corresponding file path volume/volumeMount, simplifying the manual configuration process. Thus, users can enable log collection without manually configuring each Pod.

Here is an example configuration demonstrating how to achieve automatic injection of log collection configuration via the `admission_mutate` setting in Datakit Operator:

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

`admission_mutate.loggings`: This is an array of objects, containing multiple log collection configurations. Each log configuration includes the following fields:

- `namespace_selectors`: Limits the Namespaces of Pods that meet the conditions. Multiple Namespaces can be set, and Pods must match at least one Namespace to be selected. It is an "OR" relationship with `label_selectors`.
- `label_selectors`: Limits the labels of Pods that meet the conditions. Pods must match at least one label selector to be selected. It is an "OR" relationship with `namespace_selectors`.
- `config`: This is a JSON string that will be added to the Pod's annotations. The annotation key is `datakit/logs`. If this key already exists, it will not be overwritten or duplicated. This configuration tells Datakit how to collect logs.

Datakit Operator will automatically parse the `config` configuration and create the corresponding volume and volumeMount for the Pod based on the paths (`path`) specified.

Taking the above Datakit Operator configuration as an example, if a Pod's Namespace is `middleware` or its Labels match `app=logging`, the Pod will receive the added annotations and mounts. For instance:

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

Upon discovering the Pod, Datakit log collection will proceed according to the content of `datakit/logs`.

### FAQ {#datakit-operator-faq}

- How to specify that a certain Pod should not be injected? Add the Annotation `"admission.datakit/enabled": "false"` to the Pod, and no operations will be performed on it, this has the highest priority.

- Datakit-Operator uses the Kubernetes Admission Controller function for resource injection. Detailed mechanisms can be found in the [official documentation](https://kubernetes.io/en/docs/reference/access-authn-authz/admission-controllers/){:target="_blank"}
