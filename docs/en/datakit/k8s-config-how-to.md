# Overview of DataKit Configuration in Kubernetes Environment
---

In a Kubernetes (k8s) environment, multiple configuration methods for collectors can exist, which may confuse users when configuring collectors due to differences between these methods. This article briefly introduces best practices for configuring DataKit in a K8s environment.

## Configuration Methods in K8s Environment {#intro}

The current version (>1.2.0) of DataKit supports the following configuration methods:

- Configuration via [conf](datakit-daemonset-deploy.md#configmap-setting)
- Configuration via [ENV](datakit-daemonset-deploy.md#using-k8-env)
- Configuration via [Annotation](../integrations/container-log.md#logging-with-annotation-or-label)
- Configuration via [CRD](../integrations/kubernetes-crd.md)
- Configuration via [Git](datakit-conf.md#using-gitrepo)
- Configuration via [DCA](dca.md)

If further categorized, these methods can be divided into two types:

- Configuration based on DataKit
    - conf
    - ENV
    - Git
    - DCA
- Configuration based on **the entity being collected**
    - Annotation

Given the existence of multiple configuration methods and their priority relationships, the following sections will explain each method in order of increasing priority.

### Configuration via ConfigMap {#via-configmap-conf}

When DataKit runs in a K8s environment, it behaves similarly to running on a host, as it still reads collector configurations from the _.conf_ directory. Therefore, injecting collector configurations via ConfigMap is entirely feasible and sometimes the only way, such as enabling the MySQL collector in the current DataKit version, which can only be done by injecting a ConfigMap.

### Configuration via ENV {#via-env-config}

In K8s, when starting DataKit, you can inject many environment variables into its YAML file. In addition to controlling DataKit's behavior through environment variables, some collectors also support injecting **specific environment variables** named generally as follows:

```shell
ENV_INPUT_XXX_YYY
```

Here, `XXX` refers to the collector name, and `YYY` refers to specific configuration fields within that collector's configuration. For example, `ENV_INPUT_CPU_PERCPU` adjusts whether the [CPU collector](../integrations/cpu.md) collects metrics for each CPU core (by default, this option is disabled).

Note that not all collectors currently support ENV injection. Collectors that do support ENV injection are generally [enabled by default](datakit-input-conf.md#default-enabled-inputs). Collectors enabled via ConfigMap also support ENV injection (depending on the specific collector), and **ENV injection takes precedence by default**.

> The method of injecting environment variables generally applies only to the K8s mode; the host installation method does not support injecting environment variables.

### Configuration via Annotation {#annotation}

Currently, the scope of Annotation-based configuration is narrower than that of ENV. It is mainly used to **mark the entity being collected**, such as enabling or disabling collection for certain entities (including log and metric collection).

Using Annotations to configure collectors is relatively special. For instance, in the container (Pod) log collector, if you want to disable log collection for all logs (`container_exclude_log = [image:*]`) but enable log collection for specific Pods, you can add Annotations to those specific Pods:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: testing-log-deployment
  labels:
    app: testing-log
spec:
  template:
    metadata:
      labels:
        app: testing-log
      annotations:
        datakit/logs: |    # <-------- Add a specific Key Annotation here
          [
            {
              "source": "testing-source",   # Set the source for this Pod's logs
              "service": "testing-service", # Set the service for this Pod's logs
              "pipeline": "test.p"          # Set the Pipeline for this Pod's logs
            }
          ]
    ...
```

> Note: Currently, Annotation-based configuration does not support mainstream collectors (only [Prometheus](../integrations/prom.md) is supported). More collectors will be added in the future.

So far, the main configuration methods for DataKit in a K8s environment are these three, with their priorities increasing in order: conf has the lowest priority, followed by ENV, and then Annotation has the highest priority.

- Configuration via CRD

CRD is a widely used configuration method in Kubernetes. Compared to Annotation, CRD does not require modifying the deployment of the entity being collected, making it less intrusive. See the [DataKit CRD usage documentation](../integrations/kubernetes-crd.md) for more details.

### Git Configuration Method {#git}

The Git method is supported in both host and K8s modes. Essentially, it is a conf configuration, but its conf files are not in the default _conf.d_ directory but rather in the _gitrepo_ directory under the DataKit installation directory. If Git mode is enabled, the default _conf.d_ directory's **collector configurations will no longer take effect** (except for the main configuration _datakit.conf_), but the original _pipeline_ and _pythond_ directories remain valid. This shows that Git is primarily used to manage various text configurations on DataKit, including collector configurations, Pipeline scripts, and Python scripts.

> Note: The main DataKit configuration (_datakit.conf_) cannot be managed via Git.

#### Default Collector Configuration in Git Mode {#def-inputs-under-git}

In Git mode, one important characteristic is that the **conf files of [default enabled collectors](datakit-input-conf.md#default-enabled-inputs) are hidden**, regardless of whether it is in K8s or host mode. Therefore, managing these default enabled collector configuration files with Git requires additional work to prevent them from being **duplicated**.

In Git mode, if you need to adjust the configuration of default collectors (either to disable them or make corresponding changes), there are several ways:

- Remove them from _datakit.conf_ or _datakit.yaml_. **At this point, they will no longer be default enabled collectors.**
- To modify specific collector configurations, you can:
    - Manage their conf files via Git.
    - Use ENV injection as mentioned earlier (depending on whether the collector supports ENV injection).
    - If the collector supports Annotation marking, you can also adjust it via this method.

### DCA Configuration Method {#dca}

The [DCA](dca.md) configuration method is somewhat similar to Git, as both only affect DataKit's collector configurations, Pipeline configurations, and Pythond configurations. However, DCA's functionality is less powerful than Git and is generally used for managing files on a few DataKit instances.

## Summary {#summary}

This concludes the basic introduction to the various configuration methods available for DataKit. For specific collectors, refer to their respective documentation to determine which configuration methods they support.

## Further Reading {#more-readings}

- [DataKit Configuration](datakit-conf.md)
- [DataKit Collector Configuration](datakit-input-conf.md)
- [Installing DataKit via DaemonSet](datakit-daemonset-deploy.md)
