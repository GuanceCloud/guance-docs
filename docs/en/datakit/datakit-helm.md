# Managing Configuration with Helm
---

This document explains how to manage DataKit's environment variables and collection configurations using Helm. We can maintain Helm to manage changes in DataKit's configuration.

## Installation and Configuration Modification {#instal-config}

### Download DataKit Charts Package with Helm {#dowbload-config}

```shell
helm pull datakit --repo https://pubrepo.guance.com/chartrepo/datakit --untar
```

### Modify `values.yaml` {#values-configuration}

<!-- markdownlint-disable MD046 -->
???+ warning "Attention"

     `values.yaml` is located in the `datakit` directory.
<!-- markdownlint-enable -->

#### Modify `dataway url`  {#helm-dataway}

```yaml
...
datakit:
  # DataKit will send the indicator data to dataway. Please be sure to change the parameters
  # @param dataway_url - string - optional - default: 'https://guance.com'
  # The host of the DataKit intake server to send Agent data to, only set this option
  dataway_url: https://openway.guance.com?token=tkn_xxxxxxxxxx
...
```

#### Add Default Collectors {#helm-default-config}
  
Add `RUM`, append the parameter at the end of `default_enabled_inputs`.

```yaml
..
datakit:
  ...
  # @param default_enabled_inputs - string
  # The default open collector list, format example: input1, input2, input3
  default_enabled_inputs: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,rum
....
```

#### Add Global Tags {#helm-tag}

Add the global tag `cluster_name_k8s`.

```yaml
datakit:
  ...
  # @param global_tags - string - optional - default: 'host=__datakit_hostname,host_ip=__datakit_ip'
  # It supports filling in global tags during the installation phase. The format example is: Project = ABC, owner = Zhang San (multiple tags are separated by English commas)
  global_tags: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=prod  
```

#### Add DataKit Environment Variables {#helm-env}

Refer to [Container Environment Variables](datakit-daemonset-deploy.md#using-k8-env) for more environment variables.

```yaml
# @param extraEnvs - array - optional
# extra env Add env for customization
# more, see: https://docs.guance.com/datakit/datakit-daemonset-deploy/#using-k8-env
# You can add more than one parameter  
extraEnvs:
 - name: ENV_NAMESPACE
   value: government-prod
 - name: ENV_GLOBAL_ELECTION_TAGS
   value: cluster_name_k8s=government-prod
```

#### Mount Collector Configuration {#helm-config}
  
For collecting container host system logs, `path` is the container path, which must be under `/usr/local/datakit/conf.d/`. `name` is the configuration name. `value` is the content of the collection configuration. Sample files for collectors can be obtained from the `/usr/local/datakit/conf.d/` directory inside the container.

```yaml
dkconfig:   
 - path: "/usr/local/datakit/conf.d/logging.conf"
   name: logging.conf
   value: |-
     [[inputs.logging]]
       logfiles = [
         "/var/log/syslog",
         "/var/log/message",
       ]
       ignore = [""]
       source = ""
       service = ""
       pipeline = ""
       ignore_status = []
       character_encoding = ""
       auto_multiline_detection = true
       auto_multiline_extra_patterns = []
       remove_ansi_escape_codes = true
       blocking_mode = true
       ignore_dead_log = "1h"
       [inputs.logging.tags]
```

#### Mount Pipeline {#helm-pipeline}

Using `test.p` as an example, `path` is the absolute path of the configuration file, which must be under `/usr/local/datakit/pipeline/`. `name` is the Pipeline name. `value` is the Pipeline content.

```yaml
dkconfig:
 - path: "/usr/local/datakit/pipeline/test.p"
   name: test.p
   value: |-
     # access log
     grok(_,"%{GREEDYDATA:ip_or_host} - - \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{NUMBER:http_code} ")
     grok(_,"%{GREEDYDATA:ip_or_host} - - \\[%{HTTPDATE:time}\\] \"-\" %{NUMBER:http_code} ")
     default_time(time)
     cast(http_code,"int")

     # error log
     grok(_,"\\[%{HTTPDERROR_DATE:time}\\] \\[%{GREEDYDATA:type}:%{GREEDYDATA:status}\\] \\[pid %{GREEDYDATA:pid}:tid %{GREEDYDATA:tid}\\] ")
     grok(_,"\\[%{HTTPDERROR_DATE:time}\\] \\[%{GREEDYDATA:type}:%{GREEDYDATA:status}\\] \\[pid %{INT:pid}\\] ")
     default_time(time)
```

### Install DataKit {#datakit-install}

```shell
helm install datakit datakit \
         --repo  https://pubrepo.guance.com/chartrepo/datakit \
         -n datakit --create-namespace \
         -f values.yaml
```

Output:

```shell
NAME: datakit
LAST DEPLOYED: Tue Apr  4 19:13:29 2023
NAMESPACE: datakit
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace datakit -l "app.kubernetes.io/name=datakit,app.kubernetes.io/instance=datakit" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace datakit $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:9527 to use your application"
  kubectl --namespace datakit port-forward $POD_NAME 9527:$CONTAINER_PORT
```

## Specified Version Installation {#version-install}

```shell
helm install datakit datakit \
         --repo  https://pubrepo.guance.com/chartrepo/datakit \
         -n datakit --create-namespace \
         -f values.yaml \
         --version 1.5.x
```

## Upgrade {#datakit-upgrade}

<!-- markdownlint-disable MD046 -->
???+ info

    If `values.yaml` is lost, you can execute `helm -n datakit get values datakit -o yaml > values.yaml` to retrieve it.
<!-- markdownlint-enable -->

```shell
helm upgrade datakit datakit \
         --repo  https://pubrepo.guance.com/chartrepo/datakit \
         -n datakit \
         -f values.yaml
```

## Uninstall {#datakit-uninstall}

```shell
helm uninstall datakit -n datakit 
```

## Configuration File Reference {#config-reference}

<!-- markdownlint-disable MD046 -->
???- note "values.yaml"

    ```yaml
    # Default values for datakit.
    # This is a YAML-formatted file.
    # Declare variables to be passed into your templates.

    datakit:
      # DataKit will send the indicator data to dataway. Please be sure to change the parameters
      # @param dataway_url - string - optional - default: 'https://guance.com'
      # The host of the DataKit intake server to send Agent data to, only set this option
      dataway_url: https://openway.guance.com?token=tkn_xxxxxxxxxx

      # @param global_tags - string - optional - default: 'host=__datakit_hostname,host_ip=__datakit_ip'
      # It supports filling in global tags during the installation phase. The format example is: Project = ABC, owner = Zhang San (multiple tags are separated by English commas)
      global_tags: host=__datakit_hostname,host_ip=__datakit_ip,cluster_name_k8s=government-prod

      # @param default_enabled_inputs - string
      # The default open collector list, format example: input1, input2, input3
      default_enabled_inputs: cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,rum

      # @param enabled_election - boolean
      # When the election is enabled, it is enabled by default. If it needs to be enabled, you can give any non-empty string value to the environment variable. (e.g. true / false)
      enabled_election: true

      # @param log - string
      # Set logging verbosity, valid log levels are:
      # info, debug, stdout, warn, error, critical, and off
      log_level: info

      # @param http_listen - string
      # It supports specifying the network card bound to the Datakit HTTP service during the installation phase (default localhost)
      http_listen: 0.0.0.0:9529

    image:
      # @param repository - string - required
      # Define the repository to use:
      #
      repository:  pubrepo.guance.com/datakit/datakit

      # @param tag - string - required
      # Define the Cluster-Agent version to use.
      #
      tag: ""

      # @param pullPolicy - string - optional
      # The Kubernetes [imagePullPolicy][] value
      #
      pullPolicy: Always

    # https://docs.guance.com/datakit/datakit-daemonset-deploy/

    git_repos:
      # Use Git management for DataKit input
      enable: false

      # @param git_url - string - required
      # You can set git@github.com:path/to/repository.git or http://username:password@github.com/path/to/repository.git.
      # see https://docs.guance.com/best-practices/insight/datakit-daemonset/#git
      git_url: "-"

      # @param git_key_path - string - optional
      # The Git Ssh Key Content,
      # For details,
      # -----BEGIN OPENSSH PRIVATE KEY--
      # ---xxxxx---
      #--END OPENSSH PRIVATE KEY-----
      git_key_path: "-"

      # @param git_key_pw - string - optional
      # The ssh Key Password
      git_key_pw: "-"

      # @param git_branch - string - required
      # Specifies the branch to pull. If it is blank, it is the default. The default is the main branch specified remotely, usually the master.
      git_branch: "master"

      # @param git_interval - string - required
      # Timed pull interval. (e.g. 1m)
      git_interval: "1m"
      is_use_key: false

    # If true, Datakit installs ipdb.
    # ref: https://docs.guance.com/datakit/datakit-tools-how-to/#install-ipdb
    iploc:
      enable: true
      image:
        # @param repository - string - required
        # Define the repository to use:
        #
        repository: "pubrepo.guance.com/datakit/iploc"

        # @param tag - string - required
        # Define the Cluster-Agent version to use.
        #
        tag: "1.0"

    # @param extraEnvs - array - optional
    # extra env Add env for customization
    # more, see: https://docs.guance.com/datakit/datakit-daemonset-deploy/#using-k8-env
    # You can add more than one parameter
    extraEnvs:
     - name: ENV_NAMESPACE
       value: government-prod
     - name: ENV_GLOBAL_ELECTION_TAGS
       value: cluster_name_k8s=government-prod
     # - name: ENV_NAMESPACE # electoral
     #   value: k8s
     # - name: "NODE_OPTIONS"
     #   value: "--max-old-space-size=1800"


    resources:
      requests:
        cpu: "200m"
        memory: "128Mi" 
      limits:
        cpu: "2000m"
        memory: "4Gi"

    # @param nameOverride - string - optional
    # Override name of app.
    #
    nameOverride: ""

    # @param fullnameOverride - string - optional
    # Override name of app.
    #
    fullnameOverride: ""

    podAnnotations:
      datakit/logs: |
        [{"disable": true}]

    # @param tolerations - array - optional
    # Allow the DaemonSet to schedule on tainted nodes (requires Kubernetes >= 1.6)
    #
    tolerations:
      - operator: Exists

    service:
      type: ClusterIP
      port: 9529

    # @param dkconfig - array - optional
    # Configure Datakit custom input
    #
    dkconfig: 
     - path: "/usr/local/datakit/conf.d/logging.conf"
       name: logging.conf
       value: |-
         [[inputs.logging]]
           logfiles = [
             "/var/log/syslog",
             "/var/log/message",
           ]
           ignore = [""]
           source = ""
           service = ""
           pipeline = ""
           ignore_status = []
           character_encoding = ""
           auto_multiline_detection = true
           auto_multiline_extra_patterns = []
           remove_ansi_escape_codes = true
           blocking_mode = true
           ignore_dead_log = "1h"
           [inputs.logging.tags]
     - path: "/usr/local/datakit/pipeline/test.p"
       name: test.p
       value: |-
         # access log
         grok(_,"%{GREEDYDATA:ip_or_host} - - \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{NUMBER:http_code} ")
         grok(_,"%{GREEDYDATA:ip_or_host} - - \\[%{HTTPDATE:time}\\] \"-\" %{NUMBER:http_code} ")
         default_time(time)
         cast(http_code,"int")

         # error log
         grok(_,"\\[%{HTTPDERROR_DATE:time}\\] \\[%{GREEDYDATA:type}:%{GREEDYDATA:status}\\] \\[pid %{GREEDYDATA:pid}:tid %{GREEDYDATA:tid}\\] ")
         grok(_,"\\[%{HTTPDERROR_DATE:time}\\] \\[%{GREEDYDATA:type}:%{GREEDYDATA:status}\\] \\[pid %{INT:pid}\\] ")

    # If true, deploys the kube-state-metrics deployment.
    # ref: https://github.com/kubernetes/charts/tree/master/stable/kube-state-metrics
    kubeStateMetricsEnabled: true

    # If true, deploys the metrics-server deployment.
    # ref: https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server
    MetricsServerEnabled: false
    ```
<!-- markdownlint-enable -->

## FAQ {#faq}

### PodSecurityPolicy Issues {#pod-security-policy}

`PodSecurityPolicy` has been deprecated in [Kubernetes`1.21`](https://kubernetes.io/blog/2021/04/06/podsecuritypolicy-deprecation-past-present-and-future/){:target="_blank"} and removed in Kubernetes`1.25`.
If you forcibly upgrade the cluster version, Helm deployment of `kube-state-metrics` will fail with the following error:

```shell
Error: UPGRADE FAILED: current release manifest 
contains removed kubernetes api(s) for this kubernetes
version and it is therefore unable to build the
kubernetes objects for performing the diff. error from
kubernetes: unable to recognize "": no matches for kind
"PodSecurityPolicy" in version "policy/v1beta1"
```

#### Backup Helm Values {#get-values}

```shell
helm get values -n datakit datakit -o yaml > values.yaml
```

#### Clear Helm Information {#delete-values}

Delete the secrets containing Helm information in the Datakit namespace.

- Retrieve secrets

  ```shell
  $ kubectl get secrets -n datakit
  NAME                            TYPE                 DATA   AGE
  sh.helm.release.v1.datakit.v1   helm.sh/release.v1   1      4h17m
  sh.helm.release.v1.datakit.v2   helm.sh/release.v1   1      4h17m
  sh.helm.release.v1.datakit.v3   helm.sh/release.v1   1      4h16m
  ```

- Delete secrets containing `sh.helm.release.v1.datakit`

  ```shell
  kubectl delete  secrets sh.helm.release.v1.datakit.v1 sh.helm.release.v1.datakit.v2 sh.helm.release.v1.datakit.v3   -n datakit
  ```

#### Reinstall or Upgrade {#reinstall}

```shell
helm upgrade -i -n datakit datakit  --repo  https://pubrepo.guance.com/chartrepo/datakit  -f values.yaml
```