---
title     : 'Kubernetes Audit Log Collection'
summary   : 'Kubernetes Audit Log Collection'
__int_icon: 'icon/kubernetes'
tags      :
  - 'PROMETHEUS'
  - 'KUBERNETES'
dashboard :
  - desc  : 'kubernetes Audit'
    path  : 'dashboard/en/kubernetes_audit'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes Audit Log Collection
<!-- markdownlint-enable -->

Kubernetes Audit provides security-related time series operation records (including time, source, operation results, users initiating the operation, operated resources, and detailed information about requests/responses).

## Configuration {#config}

### Prerequisites

- [x] Install K8S environment
- [x] Install [DataKit](../datakit/datakit-daemonset-deploy.md)

### Enable Audit Log Policy

❗ If already enabled, please ignore

Taking Kubernetes `1.24` as an example, enabling the audit log policy


<!-- markdownlint-disable MD031 MD032 MD009 MD034 MD046-->
- Log in to the master node server

> `cd /etc/kubernetes`

- Add audit-policy.yml

???- info "audit-policy.yml"
    ```yaml        
    # Copyright © 2022 sealos.
    #
    # Licensed under the Apache License, Version 2.0 (the "License");
    # you may not use this file except in compliance with the License.
    # You may obtain a copy of the License at
    #
    #     http://www.apache.org/licenses/LICENSE-2.0
    #
    # Unless required by applicable law or agreed to in writing, software
    # distributed under the License is distributed on an "AS IS" BASIS,
    # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    # See the License for the specific language governing permissions and
    # limitations under the License.

    apiVersion: audit.k8s.io/v1 # This is required.
    kind: Policy
    # Don't generate audit events for all requests in RequestReceived stage.
    omitStages:
    - "RequestReceived"
    rules:
    # The following requests were manually identified as high-volume and low-risk,
    # so drop them.
    - level: None
        users: [ "system:kube-proxy" ]
        verbs: [ "watch" ]
        resources:
        - group: "" # core
            resources: [ "endpoints", "services" ]
    - level: None
        users: [ "system:unsecured" ]
        namespaces: [ "kube-system" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "configmaps" ]
    - level: None
        users: [ "kubelet" ] # legacy kubelet identity
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "nodes" ]
    - level: None
        userGroups: [ "system:nodes" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "nodes" ]
    - level: None
        users:
        - system:kube-controller-manager
        - system:kube-scheduler
        - system:serviceaccount:kube-system:endpoint-controller
        verbs: [ "get", "update" ]
        namespaces: [ "kube-system" ]
        resources:
        - group: "" # core
            resources: [ "endpoints" ]
    - level: None
        users: [ "system:apiserver" ]
        verbs: [ "get" ]
        resources:
        - group: "" # core
            resources: [ "namespaces" ]
    # Don't log these read-only URLs.
    - level: None
        nonResourceURLs:
        - /healthz*
        - /version
        - /swagger*
    # Don't log events requests.
    - level: None
        resources:
        - group: "" # core
            resources: [ "events" ]
    # Secrets, ConfigMaps, and TokenReviews can contain sensitive & binary data,
    # so only log at the Metadata level.
    - level: Metadata
        resources:
        - group: "" # core
            resources: [ "secrets", "configmaps" ]
        - group: authentication.k8s.io
            resources: [ "tokenreviews" ]
    # Get repsonses can be large; skip them.
    - level: Request
        verbs: [ "get", "list", "watch" ]
        resources:
        - group: "" # core
        - group: "admissionregistration.k8s.io"
        - group: "apps"
        - group: "authentication.k8s.io"
        - group: "authorization.k8s.io"
        - group: "autoscaling"
        - group: "batch"
        - group: "certificates.k8s.io"
        - group: "extensions"
        - group: "networking.k8s.io"
        - group: "policy"
        - group: "rbac.authorization.k8s.io"
        - group: "settings.k8s.io"
        - group: "storage.k8s.io"
    # Default level for known APIs
    - level: RequestResponse
        resources:
        - group: "" # core
        - group: "admissionregistration.k8s.io"
        - group: "apps"
        - group: "authentication.k8s.io"
        - group: "authorization.k8s.io"
        - group: "autoscaling"
        - group: "batch"
        - group: "certificates.k8s.io"
        - group: "extensions"
        - group: "networking.k8s.io"
        - group: "policy"
        - group: "rbac.authorization.k8s.io"
        - group: "settings.k8s.io"
        - group: "storage.k8s.io"
        - group: "autoscaling.alibabacloud.com"
    # Default level for all other requests.
    - level: Metadata
    ```
<!-- markdownlint-enable -->

💡 Corresponding policy information can be adjusted according to actual needs.

### API Server Enable Audit Log

❗ If already enabled, please ignore

Enter the directory `/etc/kubernetes/manifests`, first back up the `kube-apiserver.yaml` file, and the backed-up file should not be placed under `/etc/kubernetes/manifests/`. Adjust the content of the file.

- Add commands under `spec.containers.command`:

```yaml
  - command:
    - kube-apiserver
    - --advertise-address=10.0.16.204
    - --allow-privileged=true
    - --audit-log-format=json
    - --audit-log-maxage=7
    - --audit-log-maxbackup=10
    - --audit-log-maxsize=100
    - --audit-log-path=/var/log/kubernetes/audit.log
    - --audit-policy-file=/etc/kubernetes/audit-policy.yml
```

- Add under `spec.containers.volumeMounts`:

```yaml
    - mountPath: /etc/kubernetes
      name: audit
    - mountPath: /var/log/kubernetes
      name: audit-log
```

- Add under `spec.volumes`:

```yaml
  - hostPath:
      path: /etc/kubernetes
      type: DirectoryOrCreate
    name: audit
  - hostPath:
      path: /var/log/kubernetes
      type: DirectoryOrCreate
    name: audit-log
```

- Take effect

After modifying the API Server, it will automatically restart. Wait patiently for a few minutes.

- Verify

Run the following command to check if the `audit.log` file is generated. If it exists, it proves that the configuration has taken effect.

> `ls /var/log/kubernetes`


### Collect K8S Audit Logs

K8S audit logs are stored in the `/var/log/kubernetes` directory of the corresponding `master` node. Here, we use the `annotation` method for collection.

- Create pod: k8s-audit-log.yaml

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: kube-audit-log
  annotations:
        datakit/logs: |
          [
            {
              "disable": false,
              "type": "file",
              "path":"/var/log/kubernetes/audit.log",
              "source":  "k8s-audit",
              "tags" : {
                "atype": "kube-audit-log"
              }
            }
          ]

spec:
  containers:
  - name: kube-audit-log
    image: busybox
#    command: ["sleep", "1"]
    args:
    - /bin/sh
    - -c
    - >
      i=0;
      while true;
      do
        i=$((i+1));
        sleep 10;
      done
    volumeMounts:
    - mountPath: /var/log/kubernetes
      name: datakit-vol-opt
  volumes:
  - name: datakit-vol-opt
    hostPath: 
      path: /var/log/kubernetes
  nodeSelector:
     kubernetes.io/hostname: k8s-master
  tolerations:
  - key: "node-role.kubernetes.io/master"
    operator: "Exists"
    effect: "NoSchedule"
  - key: "node-role.kubernetes.io/control-plane"
    operator: "Exists"
    effect: "NoSchedule"
```

❗ Note that this pod can only run on the master node.

- Execute

```shell
kubectl apply -f k8s-audit-log.yaml 
```

- View

After a few minutes, you can view the corresponding logs on <<< custom_key.brand_name >>>. Since they are in `json` format, <<< custom_key.brand_name >>> supports searching via the `@+json` field name, such as `@verb:update`.

### Audit Log Field Extraction

After collecting audit logs, through <<< custom_key.brand_name >>>'s `pipeline` capabilities, key fields from the audit logs can be extracted for further analysis.

- On <<< custom_key.brand_name >>>, `Logs` - `Pipeline` - `Create`
- Select the corresponding log source `k8s-audit`
- `Pipeline` Name: `kubelet-audit`
- Define parsing rules

```python
abc = load_json(_)

add_key(kind, abc["kind"])
add_key(level, abc["level"])
add_key(stage, abc["stage"])
add_key(verb, abc["verb"])
add_key(auditID, abc["auditID"])
add_key(username, abc["user"]["username"])
add_key(responseCode, abc["responseStatus"]["code"])
if abc["responseStatus"]["code"]==200 {
  add_key(status, "OK")
}else{
  add_key(status, "FAIL")
}
add_key(sourceIP_0,abc["sourceIPs"][0])
  
add_key(namespace,abc["objectRef"]["namespace"])
add_key(node,abc["objectRef"]["name"])
```

- Click to test the script
- Save