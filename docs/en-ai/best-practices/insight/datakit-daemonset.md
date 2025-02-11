# DataKit DaemonSet Configuration Management Best Practices

---

## Background Introduction

Due to the complexity of [Datakit DaemonSet](/datakit/datakit-daemonset-deploy/) configuration management, this article will introduce best practices for configuration management.

This document will describe configuration methods for two different deployment approaches.

## Helm Deployment Configuration Best Practices

### Prerequisites

- Kubernetes >= 1.14
- Helm >= 2.17.0

### Configuring Monitoring for Mysql and Pipeline Files

#### Adding Helm Repository

```shell
helm add repo dataflux https://pubrepo.guance.com/chartrepo/datakit
```

#### Viewing DataKit Versions

```shell
helm search repo datakit
NAME                	CHART VERSION	APP VERSION	DESCRIPTION
dataflux/datakit	1.2.10       	1.2.10     	Chart for the DaemonSet datakit
```

#### Downloading Helm Package

```shell
helm repo update 
helm pull datakit/datakit --untar
```

![image.png](../images/datakit-daemonset-1.png)

#### Modifying Value Configuration

Modify `datakit/values.yaml`

Note the YAML format; both `dataway_url` and `dkconfig` need to be updated.

The `values.yaml` file can be used for future upgrades.

```yaml
dataway_url: https://openway.guance.com?token=<your-token>

... 
dkconfig:
  - path: "/usr/local/datakit/conf.d/db/mysql.conf"
    name: mysql.conf
    value: |
      # {"version": "1.1.9-rc7.1", "desc": "do NOT edit this line"}
      [[inputs.mysql]]
        host = "192.168.0.3"
        user = "root"
        pass = "S6QgMvrer2!8xvMD"
        port = 3306
        interval = "10s"
        innodb = true
        tables = []
        users = []
        [inputs.mysql.dbm_metric]
          enabled = true
        ## Monitoring sampling configuration
        [inputs.mysql.dbm_sample]
          enabled = true
        [inputs.mysql.tags]
          # some_tag = "some_value"
          # more_tag = "some_other_value"
  - path: "/usr/local/datakit/pipeline/java.p"
    name: java.p
    value: |
      json(_, recorder, 'recorder')
      if recorder == "gunicorn" {
        drop_key(func_name)
        json(_, func_name, 'func_name')
        json(_, remote_addr, 'remote_addr')
        json(_, time_local, 'time_local')
        json(_, time_unix, 'time_unix')
        json(_, level, 'level')
        json(_, method, 'method')
        json(_, path, 'path')
        json(_, cost_time, 'cost_time')
        json(_, res_status, 'res_status')
        json(_, res_length, 'res_length')
        json(_, trace_id, 'trace_id')
        add_key(__type, "gunicorn")
      }
      if recorder == "Forethought" {
        json(_, source, 'resource')
        json(_, app, 'app')
        json(_, level, 'level')
        json(_, cc_timestamp, 'cc_timestamp')
        json(_, name, 'name')
        json(_, log_time, 'log_time')
        json(_, message, 'remessage')
              json(_, trace_id, 'trace_id')
        add_key(__type, "Forethought")
      }
      lowercase(level)
      group_in(level, ["error", "panic", "dpanic", "fatal"], "error", status)
      group_in(level, ["info", "debug"], "info", status)
      group_in(level, ["warn", "warning"], "warning", status)

```

#### Installing or Upgrading DataKit

```shell
cd datakit
helm repo update 
helm install my-datakit datakit/datakit -f values.yaml -n datakit --create-namespace \
    --set image.tag=1.2.11
```

```shell
helm repo update 
helm upgrade my-datakit . -n datakit -f values.yaml --set image.tag=1.2.11

Release "datakit" has been upgraded. Happy Helming!
NAME: datakit
LAST DEPLOYED: Sat Apr  2 15:33:55 2022
NAMESPACE: datakit
STATUS: deployed
REVISION: 10
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace datakit -l "app.kubernetes.io/name=datakit,app.kubernetes.io/instance=datakit" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace datakit $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace datakit port-forward $POD_NAME 8080:$CONTAINER_PORT

```

#### Checking Deployment Success

```shell
helm list -n datakit
kubectl get pods -n datakit
```


## Enabling Git Deployment Configuration Best Practices

Datakit [Enabling Git](/datakit/datakit-conf/) Management

### Prerequisites

- A Git repository is already prepared.
- Directory structure:
```shell
├── README.md
├── conf.d
│   ├── container.conf
│   └── net_ebpf.conf
└── pipeline
    ├── corestone.p
    ├── kodo.p
    ├── nsqd.p
    ├── py-forethought-core.p
    └── py.p
```

![image.png](../images/datakit-daemonset-2.png)


### Enabling Git Deployment via Helm

Note: Enabling Git configuration management renders ConfigMap ineffective, and `default_enabled_inputs` will not have any effect.

- Using Password to Manage Git

You need to modify `dataway_url`, `git_repos.git_url`.

```shell
helm add repo dataflux https://pubrepo.guance.com/chartrepo/datakit
helm repo update 
helm install my-datakit datakit/datakit -n datakit --set dataway_url="https://openway.guance.com?token=<your-token>" \
--set git_repos.git_url="http://username:password@github.com/path/to/repository.git" \
--create-namespace 
```

- Using Git Key to Manage Git

You need to modify `dataway_url`, `git_repos.git_url`, `git_repos.git_key_path` (absolute path).

```shell
helm add repo dataflux https://pubrepo.guance.com/chartrepo/datakit
helm repo update 
helm install my-datakit datakit/datakit -n datakit --set dataway_url="https://openway.guance.com?token=<your-token>" \
--set git_repos.git_url="git@github.com:path/to/repository.git" \
--set-file git_repos.git_key_path="/Users/buleleaf/.ssh/id_rsa" \
--create-namespace 
```

### Enabling Git Deployment via YAML

First, download [datakit.yaml](https://static.guance.com/datakit/datakit.yaml)

- Using Password to Manage Git

Modify `datakit.yaml`, add `env`

```shell
        - name: ENV_GIT_URL
          value: "http://username:password@github.com/path/to/repository.git"
        - name: ENV_GIT_BRANCH
          value: "master"
        - name: ENV_GIT_INTERVAL
          value: "1m"
```

- Using Git Key to Manage Git

Add ConfigMap
```shell
apiVersion: v1
data:
  id-rsa: |-

    -----BEGIN OPENSSH PRIVATE KEY-----
    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
    -----END OPENSSH PRIVATE KEY-----
kind: ConfigMap
metadata:
  name: id-rsa
  namespace: datakit


```

Add env

```shell
        - name: ENV_GIT_URL
          value: "git@github.com:path/to/repository.git"
        - name: ENV_GIT_KEY_PATH
          value: "/usr/local/datakit/id_rsa"
        - name: ENV_GIT_BRANCH
          value: "master"
        - name: ENV_GIT_INTERVAL
          value: "1m"
```
Add volume
```shell
        volumeMounts:
        - mountPath: /usr/local/datakit/id_rsa
          name: id-rsa
      volumes:
      - configMap:
          defaultMode: 420
          name: id-rsa
        name: id-rsa
```