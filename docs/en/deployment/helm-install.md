# Helm Deployment

## Introduction

Helm is based on Go template language. Users only need to provide the specified directory structure and template files. During actual deployment, the Helm template engine can render them into true Kubernetes resource configuration files and deploy them to nodes in the correct order.

## Basic Information and Compatibility

| Name         | Description                       |
| :-----------:| :-------------------------------- |
| Helm Version | 3.8                              |
| Offline Installation Supported | Yes                             |
| Supported Architectures | amd64/arm64                   |

## Installation

=== "Amd"

    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/helm-v3.8.0-linux-amd64.tar.gz && tar -xvf helm-v3.8.0-linux-amd64.tar.gz && mv linux-amd64/helm /bin
    ```

=== "Arm"

    ```shell
    wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/helm-v3.10.2-linux-arm64.tar.gz && tar -xvf helm-v3.10.2-linux-arm64.tar.gz && mv linux-arm64/helm /bin
    ```

## Verify Installation

```shell
helm -h
```

Output:

```
helm -h
The Kubernetes package manager

Common actions for Helm:

- helm search:    search for charts
- helm pull:      download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts

Environment variables:

| Name                               | Description                                                                                       |
|------------------------------------|---------------------------------------------------------------------------------------------------|
| $HELM_CACHE_HOME                   | set an alternative location for storing cached files.                                             |
| $HELM_CONFIG_HOME                  | set an alternative location for storing Helm configuration.                                       |
| $HELM_DATA_HOME                    | set an alternative location for storing Helm data.                                                |
| $HELM_DEBUG                        | indicate whether or not Helm is running in Debug mode                                             |
| $HELM_DRIVER                       | set the backend storage driver. Values are: configmap, secret, memory, sql.                       |
| $HELM_DRIVER_SQL_CONNECTION_STRING | set the connection string the SQL storage driver should use.                                      |
| $HELM_MAX_HISTORY                  | set the maximum number of helm release history.                                                   |
| $HELM_NAMESPACE                    | set the namespace used for the helm operations.                                                   |
| $HELM_NO_PLUGINS                   | disable plugins. Set HELM_NO_PLUGINS=1 to disable plugins.                                        |
| $HELM_PLUGINS                      | set the path to the plugins directory                                                             |
| $HELM_REGISTRY_CONFIG              | set the path to the registry config file.                                                         |
| $HELM_REPOSITORY_CACHE             | set the path to the repository cache directory                                                    |
| $HELM_REPOSITORY_CONFIG            | set the path to the repositories file.                                                            |
| $KUBECONFIG                        | set an alternative Kubernetes configuration file (default "~/.kube/config")                       |
| $HELM_KUBEAPISERVER                | set the Kubernetes API Server Endpoint for authentication                                         |
| $HELM_KUBECAFILE                   | set the Kubernetes certificate authority file.                                                    |
| $HELM_KUBEASGROUPS                 | set the Groups to use for impersonation using a comma-separated list.                             |
| $HELM_KUBEASUSER                   | set the Username to impersonate for the operation.                                                |
| $HELM_KUBECONTEXT                  | set the name of the kubeconfig context.                                                           |
| $HELM_KUBETOKEN                    | set the Bearer KubeToken used for authentication.                                                 |
| $HELM_KUBEINSECURE_SKIP_TLS_VERIFY | indicate if the Kubernetes API server's certificate validation should be skipped (insecure)       |
| $HELM_KUBETLS_SERVER_NAME          | set the server name used to validate the Kubernetes API server certificate                        |
| $HELM_BURST_LIMIT                  | set the default burst limit in the case the server contains many CRDs (default 100, -1 to disable)|

Helm stores cache, configuration, and data based on the following configuration order:

- If a HELM_*_HOME environment variable is set, it will be used
- Otherwise, on systems supporting the XDG base directory specification, the XDG variables will be used
- When no other location is set a default location will be used based on the operating system

By default, the default directories depend on the Operating System. The defaults are listed below:

| Operating System | Cache Path                | Configuration Path             | Data Path               |
|------------------|---------------------------|--------------------------------|-------------------------|
| Linux            | $HOME/.cache/helm         | $HOME/.config/helm             | $HOME/.local/share/helm |
| macOS            | $HOME/Library/Caches/helm | $HOME/Library/Preferences/helm | $HOME/Library/helm      |
| Windows          | %TEMP%\helm               | %APPDATA%\helm                 | %APPDATA%\helm          |

Usage:
  helm [command]

Available Commands:
  completion  generate autocompletion scripts for the specified shell
  create      create a new chart with the given name
  dependency  manage a chart's dependencies
  env         Helm client environment information
  get         download extended information of a named release
  help        Help about any command
  history     fetch release history
  install     install a chart
  lint        examine a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      install, list, or uninstall Helm plugins
  pull        download a chart from a repository and (optionally) unpack it in local directory
  push        push a chart to remote
  registry    login to or logout from a registry
  repo        add, list, remove, update, and index chart repositories
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  show        show information of a chart
  status      display the status of the named release
  template    locally render templates
  test        run tests for a release
  uninstall   uninstall a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client version information

Flags:
      --burst-limit int                 client-side default throttling limit (default 100)
      --debug                           enable verbose output
  -h, --help                            help for helm
      --kube-apiserver string           the address and the port for the Kubernetes API server
      --kube-as-group stringArray       group to impersonate for the operation, this flag can be repeated to specify multiple groups.
      --kube-as-user string             username to impersonate for the operation
      --kube-ca-file string             the certificate authority file for the Kubernetes API server connection
      --kube-context string             name of the kubeconfig context to use
      --kube-insecure-skip-tls-verify   if true, the Kubernetes API server's certificate will not be checked for validity. This will make your HTTPS connections insecure
      --kube-tls-server-name string     server name to use for Kubernetes API server certificate validation. If it is not provided, the hostname used to contact the server is used
      --kube-token string               bearer token used for authentication
      --kubeconfig string               path to the kubeconfig file
  -n, --namespace string                namespace scope for this request
      --registry-config string          path to the registry config file (default "/root/.config/helm/registry/config.json")
      --repository-cache string         path to the file containing cached repository indexes (default "/root/.cache/helm/repository")
      --repository-config string        path to the file containing repository names and URLs (default "/root/.config/helm/repositories.yaml")

Use "helm [command] --help" for more information about a command.

```

## Uninstallation

```shell
rm -f /bin/helm
```

## Related Commands

### Add Helm Repository

```shell
helm repo add stable https://charts.helm.sh/stable
```

Output:

```shell
"stable" has been added to your repositories
```

### List Added Repositories

```shell
helm repo list
```

Output:

```shell
NAME          	URL
stable        	https://charts.helm.sh/stable
```

### Search Charts in Repository

```shell
helm search repo stable
```

Output:

```shell
NAME                                  CHART VERSION	APP VERSION             DESCRIPTION
stable/acs-engine-autoscaler          2.2.2        	2.1.1                   DEPRECATED Scales worker nodes within agent pools
stable/aerospike                      0.3.5        	v4.5.0.5                DEPRECATED A Helm chart for Aerospike in Kubernetes...
stable/airflow                        7.13.3       	1.10.12                 DEPRECATED - please use: https://github.com/air...
stable/ambassador                     5.3.2        	0.86.1                  DEPRECATED A Helm chart for Datawire Ambassador
stable/anchore-engine                 1.7.0        	0.7.3                   Anchore container analysis and policy evaluation...
stable/apm-server                     2.1.7        	7.0.0                   DEPRECATED The server receives data from the El...
...
```

### Update Local Repository List

```shell
helm repo update
```

Output:

```shell
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
```

### Search for Redis

```shell
helm search repo redis
```

Output:

```shell
NAME                            	CHART VERSION	APP VERSION	DESCRIPTION
stable/prometheus-redis-exporter	3.5.1        	1.3.4      	DEPRECATED Prometheus exporter for Redis metrics
stable/redis                    	10.5.7       	5.0.7      	DEPRECATED Open source, advanced key-value store...
stable/redis-ha                 	4.4.6        	5.0.6      	DEPRECATED - Highly available Kubernetes implement...
stable/sensu                    	0.2.5        	0.28       	DEPRECATED Sensu monitoring framework backed by...
```

### View Redis Chart Details

```shell
helm show chart stable/redis
```

Output:

```shell
apiVersion: v1
appVersion: 5.0.7
deprecated: true
description: DEPRECATED Open source, advanced key-value store. It is often referred
  to as a data structure server since keys can contain strings, hashes, lists, sets
  and sorted sets.
home: http://redis.io/
icon: https://bitnami.com/assets/stacks/redis/img/redis-stack-220x234.png
keywords:
- redis
- keyvalue
- database
name: redis
sources:
- https://github.com/bitnami/bitnami-docker-redis
version: 10.5.7
```

### View Redis Values (Values: Equivalent to the chart's configuration file)

```shell
helm show values stable/redis
```

Output:

```shell
## Global Docker image parameters
## Please, note that this will override the image parameters, including dependencies, configured to use the global value
## Current available global Docker image parameters: imageRegistry and imagePullSecrets
##
global:
...
```

### Debugging

Run `--dry-run` to check if the generated YAML file has any issues.

```shell
helm install redis-demo stable/redis -n test --create-namespace --dry-run
```

### Install Redis Using Helm

```shell
helm install redis-demo stable/redis -n test --create-namespace
```

Output:

```shell
WARNING: This chart is deprecated
NAME: redis-demo
LAST DEPLOYED: Fri Jan  6 22:53:15 2023
NAMESPACE: test
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
This Helm chart is deprecated

...

To get your password run:

    export REDIS_PASSWORD=$(kubectl get secret --namespace test redis-demo -o jsonpath="{.data.redis-password}" | base64 --decode)

To connect to your Redis server:

1. Run a Redis pod that you can use as a client:

   kubectl run --namespace test redis-demo-client --rm --tty -i --restart='Never' \
    --env REDIS_PASSWORD=$REDIS_PASSWORD \
   --image docker.io/bitnami/redis:5.0.7-debian-10-r32 -- bash

2. Connect using the Redis CLI:
   redis-cli -h redis-demo-master -a $REDIS_PASSWORD
   redis-cli -h redis-demo-slave -a $REDIS_PASSWORD

To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace test svc/redis-demo-master 6379:6379 &
    redis-cli -h 127.0.0.1 -p 6379 -a $REDIS_PASSWORD
```

### Upgrade or Uninstall Application

```shell
# Upgrade
helm upgrade redis-demo stable/redis -n test

# Uninstall
helm uninstall redis-demo stable/redis -n test
```