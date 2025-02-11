# Overview of DataKit Configuration in Kubernetes Environment
---

In a Kubernetes (k8s) environment, there can be multiple ways to configure collectors, which can lead to confusion about the differences between these methods. This article briefly introduces best practices for configuring DataKit in a K8s environment.

## Configuration Methods in K8s Environment {#intro}

The current version (>1.2.0) of DataKit supports the following configuration methods:

- Through [conf](datakit-daemonset-deploy.md#configmap-setting) configuration
- Through [ENV](datakit-daemonset-deploy.md#using-k8-env) configuration
- Through [Annotation](../integrations/container-log.md#logging-with-annotation-or-label) configuration
- Through [CRD](../integrations/kubernetes-crd.md) configuration
- Through [Git](datakit-conf.md#using-gitrepo) configuration
- Through [DCA](dca.md) configuration

If further categorized, these methods can be divided into two types:

- Configuration based on DataKit
    - conf
    - ENV
    - Git
    - DCA
- Configuration based on **collected entities**
    - Annotation

Given the various configuration methods and their priority relationships, the following sections will explain each method in order of increasing priority.

### Configuration via ConfigMap {#via-configmap-conf}

When DataKit runs in a K8s environment, it behaves similarly to running on a host machine, as it still reads collector configurations from the _.conf_ directory. Therefore, injecting collector configurations via ConfigMap is entirely feasible and sometimes the only way. For example, enabling the MySQL collector in the current DataKit version can only be done by injecting a ConfigMap.

### Configuration via ENV {#via-env-config}

In K8s, when starting DataKit, you can inject many environment variables into its YAML file. In addition to controlling DataKit behavior through environment variables, some collectors also support injecting **specific environment variables**. These are generally named as follows:

```shell
ENV_INPUT_XXX_YYY
```

Here, `XXX` refers to the collector name, and `YYY` refers to specific configuration fields within that collector's configuration. For instance, `ENV_INPUT_CPU_PERCPU` adjusts whether the [CPU collector](../integrations/cpu.md) collects metrics for each CPU core (by default, this option is disabled).

Note that not all collectors support ENV injection. Collectors that do support ENV injection are generally [enabled by default](datakit-input-conf.md#default-enabled-inputs). Collectors enabled via ConfigMap also support ENV injection (depending on the collector), with **priority given to ENV injection**.

> Environmental variable injection is generally only applicable in K8s mode; host installation methods currently do not support injecting environment variables.

### Configuration via Annotation {#annotation}

Annotation configuration has a narrower scope compared to ENV. It is mainly used to **mark collected entities**, such as enabling/disabling collection for specific entities (including log and metric collection).

Using annotations to control collector configurations is relatively specialized. For example, if you want to disable log collection for all containers (`container_exclude_log = [image:*]`) but enable it for specific Pods, you can add an annotation to those Pods:

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
        datakit/logs: |    # <-------- Add specific Key annotation here
          [
            {
              "source": "testing-source",   # Set the source for this Pod's logs
              "service": "testing-service", # Set the service for this Pod's logs
              "pipeline": "test.p"          # Set the Pipeline for this Pod's logs
            }
          ]
    ...
```

> Note: Currently, Annotation does not support enabling mainstream collectors (only [Prometheus](../integrations/prom.md) is supported). More collectors will be added in the future.

To date, the main configuration methods for DataKit in a K8s environment are threefold, with their priorities increasing in the following order: conf has the lowest priority, followed by ENV, and then Annotation has the highest priority.

- Configuration via CRD

CRD is a widely used configuration method in Kubernetes. Compared to Annotation, CRD does not require modifying the deployment of the collected objects, making it less intrusive. See the [DataKit CRD usage documentation](../integrations/kubernetes-crd.md) for more details.

### Git Configuration Method {#git}

The Git method is supported in both host and K8s modes. Essentially, it is a conf configuration, but the conf files are stored in the _gitrepo_ directory under the DataKit installation directory rather than the default _conf.d_ directory. If Git mode is enabled, the collector configurations in the default _conf.d_ directory will no longer take effect (except for the main configuration file _datakit.conf_), but the original _pipeline_ and _pythond_ directories remain valid. From this, it is clear that Git primarily manages various text configurations on DataKit, including collector configurations, Pipeline scripts, and Python scripts.

> Note: The main DataKit configuration (_datakit.conf_) cannot be managed via Git.

#### Default Collector Configuration in Git Mode {#def-inputs-under-git}

In Git mode, one important feature is that the **conf files of default-enabled collectors are hidden**. To manage these default collectors' configurations using Git, additional work is required to avoid duplicate collection.

In Git mode, if you want to adjust the configuration of default collectors (either disable them or modify their settings), you can use several methods:

- Remove them from _datakit.conf_ or _datakit.yaml_. **They will no longer be default-enabled collectors.**
- Modify specific collector configurations in the following ways:
    - Manage their conf files via Git
    - Use ENV injection as mentioned earlier (if the collector supports ENV injection)
    - If the collector supports Annotation, you can also use that method to adjust its configuration

### DCA Configuration Method {#dca}

The [DCA](dca.md) configuration method is somewhat similar to Git, as both affect DataKit's collector configurations, Pipeline configurations, and Pythond configurations. However, DCA is less powerful than Git and is generally used for managing files on a few DataKit instances.

## Summary {#summary}

This overview covers the basic configuration methods for DataKit. For specific support of configuration methods by individual collectors, refer to the respective collector documentation.

## Further Reading {#more-readings}

- [DataKit Configuration](datakit-conf.md)
- [DataKit Collector Configuration](datakit-input-conf.md)
- [DaemonSet Installation of DataKit](datakit-daemonset-deploy.md)