---
title     : 'Kubernetes Audit'
summary   : 'Kubernetes Audit'
__int_icon: 'icon/kubernetes'
dashboard :
  - desc  : 'kubernetes Audit'
    path  : 'dashboard/en/kubernetes_audit'
monitor   :
  - desc  : 'No'
    path  : '-'
---

<!-- markdownlint-disable MD025 -->
# Kubernetes Audit Log
<!-- markdownlint-enable -->

`Kubernetes Audit` provides security related temporal operation records (including time, source, operation result, user initiating the operation, resources of the operation, and detailed information of the request/response).

## Configuration{#config}

### Preconditions

- [x] Installed K8S
- [x] Installed [DataKit](../datakit/datakit-daemonset-deploy.md)

### Enable audit log strategy

❗If enabled, please ignore.

Taking Kubernetes `1.24` as an example, enable the audit log strategy

<!-- markdownlint-disable MD031 MD032 MD009 MD034 MD046-->

- Login to the main node server

> `cd /etc/kubernetes`

- add audit-policy.yml

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
💡The corresponding strategy information can be adjusted according to actual needs.

### Enable audit logs

❗If enabled, please ignore.

Enter the directory  `/etc/kubernetes/manifests`,back up `kube-apiserver.yaml`,and the backed up file cannot be placed under`/etc/kubernetes/manifests/`, Adjust the file content

- Add a command under `spec.containers.command`：

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


- Add a command under `spec.containers.volumeMounts`：

```yaml
    - mountPath: /etc/kubernetes
      name: audit
    - mountPath: /var/log/kubernetes
      name: audit-log
```

- Add a command under `spec.volumes`：

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

- Effect

After the API Server is modified, it will automatically restart. Please wait patiently for a few minutes.

- Verify

Execute the following command to see if a `audit.log` file has been generated, and if so, it indicates that it has taken effect.

> `ls /var/log/kubernetes`


### Collect K8S audit logs

The K8S audit logs are stored in the `/var/log/kubernetes` directory of the corresponding master node, and are collected using the `annotation` method here.

- Created pod: k8s-audit-log.yaml

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

❗Please note that the current pod can only run on the master node.

- Run

> kubectl apply -f k8s-audit-log.yaml

- View


After a few minutes, you can view the corresponding logs on the observation cloud. Due to its `JSON` format, Observation Cloud supports searching through `@+JSON` field names, such as `@verb: update`.



### Audit log field extraction

After the audit logs are collected, by Guance `pipeline`, key fields of the audit logs can be extracted for further data analysis

- Login Guance console, `log` - `pipeline` - `Created`
- Select the corresponding log source `k8s-audit`
- `Pipeline` name：`kubelet-audit`
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

- Click to obtain script test
- Save
