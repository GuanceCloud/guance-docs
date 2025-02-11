# Dataway Sink
---

[:octicons-tag-24: Version-1.14.0](../datakit/changelog.md#cl-1.14.0) version of Datakit is required to use the Sinker feature described here.

---

## Introduction to Dataway Sinker {#sink-intro}

During routine data collection, due to the existence of multiple different workspaces, we may need to send different data to different workspaces. For example, in a shared Kubernetes cluster, the collected data might involve different teams or business departments. In such cases, we can route data with specific attributes to various workspaces, achieving fine-grained collection under the scenario of shared infrastructure.

The basic network topology is as follows:

```mermaid
flowchart TD
dw(Dataway);
dk(Datakit);
etcd[(etcd)];
sinker(分流);
wksp1(Workspace 1);
wksp2(Workspace 2);
wkspx(Fallback Workspace);
rules(Routing Rules);
as_default{Fallback rule exists?};
drop(Discard data/request);

subgraph "Datakit Cluster"
dk
end

dk -.-> |HTTP: X-Global-Tags/Secret-Token|dw

subgraph "Dataway Cluster(Nginx)"
%%direction LR
rules -->  dw --> sinker

sinker --> |Rule 1 matches|wksp1;
sinker --> |Rule 2 matches|wksp2;
sinker --> |No rules match|as_default -->|No|drop;
as_default -->|Yes|wkspx;
end

subgraph "Workspace Changes"
direction BT
etcd -.-> |Key change notification|rules
end
```

### Cascaded Mode of Dataway {#cascaded}

For SaaS users, a Dataway can be deployed locally (k8s Cluster) specifically for routing, and then forward the data to Openway:

<!-- markdownlint-disable MD046 -->
???+ warning

    In cascaded mode, the Dataway within the cluster needs to enable the cascaded option. Refer to the [environment variable description](dataway.md#dw-envs) in the installation documentation.
<!-- markdownlint-enable -->

```mermaid
flowchart LR;
dk1(Datakit-A);
dk2(Datakit-B);
dk3(Datakit-C);
sink_dw(Dataway);
openway(Openway);
etcd(etcd);
%%

subgraph "K8s Cluster"
dk1 ---> sink_dw
dk2 ---> sink_dw
dk3 ---> sink_dw
etcd-.-> |Routing rules|sink_dw
end

subgraph "SaaS"
sink_dw --> |Routing|openway;
sink_dw --> |Routing|openway;
end
```

Impact of cascading:

- Some API behaviors will differ. Due to historical reasons, there are differences between the request URLs from Datakit and those on Kodo, where Dataway plays the role of an API translator. In cascaded scenarios, the API translation function is disabled.
- The cascaded Dataway does not send heartbeat requests to the center. Since the next-level Dataway does not process this request (hence 404)
- When the cascaded Dataway receives a request, it does not sign the API when forwarding it to the next Dataway.

## Dataway Installation {#dw-install}

Refer to [here](dataway.md#install)

## Dataway Configuration {#dw-config}

In addition to the regular settings for Dataway, a few additional configurations need to be set (located at */usr/local/cloudcare/dataflux/dataway/dataway.yaml*):

```yaml
# Set the upload address for Dataway, generally Kodo, but it can also be another Dataway
remote_host: https://kodo.guance.com

# If the upload address is Dataway, this should be set to true, indicating Dataway cascading
cascaded: false

# This token is a randomly set token on Dataway; it needs to be filled into the
# Datakit's datakit.conf configuration. It should have a certain length and format.
secret_token: tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Sinker rule settings
sinker:
  etcd: # Supports etcd
    urls:
    - http://localhost:2379
    dial_timeout: 30s
    key_space: /dw_sinker
    username: "dataway"
    password: "<PASSWORD>"

  #file: # Also supports local file method, commonly used for debugging
  #  path: /path/to/sinker.json
```

<!-- markdownlint-disable MD046 -->
???+ warning

    If `secret_token` is not set, any request sent by Datakit can pass through, which will not cause data issues. However, if Dataway is deployed publicly, it is recommended to set `secret_token`.
<!-- markdownlint-enable -->

### Sinker Rule Settings {#setup-sinker-rules}

Dataway Sinker rules are a set of JSON configurations. The matching rules are written similarly to blacklists; refer to [here](../datakit/datakit-filter.md).

Currently, two sources of configuration are supported:

- Specifying a JSON file locally, mainly used for debugging Sinker rules. In this case, after updating the Sinker rules in the JSON file, **Dataway needs to be restarted for changes to take effect**.
- etcd: Storing debugged rules in etcd allows direct updates to etcd for minor adjustments, **without needing to restart Dataway**.

Actually, the JSON stored in etcd is identical to the local JSON file content. Below, only the etcd托管方式 is introduced.

#### etcd Configuration {#etcd-settings}

> All commands below are operated on Linux.

As an etcd client, Dataway can configure the following usernames and roles in etcd (etcd 3.5+), refer to [here](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#using-etcdctl-to-authenticate){:target="_blank"}

Create a `dataway` account and corresponding role:

```shell
# Add username, prompting for password
$ etcdctl user add dataway

# Add the sinker role
$ etcdctl role add sinker

# Add dataway to the role
$ etcdctl user grant-role dataway sinker

# Restrict role key permissions (the keys /dw_sinker and /ping are default keys used)
$ etcdctl role grant-permission sinker readwrite /dw_sinker
$ etcdctl role grant-permission sinker readwrite /ping       # Used for connectivity checks
```

<!-- markdownlint-disable MD046 -->
???+ info "Why create roles?"

    Roles control the permissions of corresponding users on certain keys. Here, we might be using an existing etcd service, so it's necessary to restrict Dataway's data permissions.

???+ warning

    If etcd has enabled [authentication mode](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#enabling-authentication){:target="_blank"}, when executing `etcdctl` commands, you need to include the corresponding username and password:

    ```shell
    $ etcdctl --user name:password ...
    ```
<!-- markdownlint-enable -->

#### Writing Sinker Rules {#prepare-sink-rules}

> New versions (1.3.6) of Dataway support managing etcd-based Sinker rules via the `dataway` command.

Assuming the *sinker.json* rule definition is as follows:

```json
{
    "strict":true,
    "rules": [
        {
            "rules": [
                "{ host = 'my-host'}"
            ],
            "url": "https://kodo.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
        },
        {
            "rules": [
                "{ host = 'my-host' OR cluster = 'cluster-A' }"
            ],
            "url": "https://kodo.guance.com?token=tkn_yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
        }
     ]
}
```

The following command writes the Sinker rule configuration:

```shell
$ etcdctl --user dataway:PASSWORD put /dw_sinker "$(<sinker.json)"
OK
```

<!-- markdownlint-disable MD046 -->
???+ tip "Marking Workspace Information"

    Since *sinker.json* does not support comments, we can add an `info` field in JSON as a memo to achieve a commenting effect:

    ``` json hl_lines="5"
    {
        "rules": [
            "{ host = 'my-host' OR cluster = 'cluster-A' }"
        ],
        "info": "This is the yyy workspace",
        "url": "https://kodo.guance.com?token=tkn_yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
    }
    ```
<!-- markdownlint-enable -->

#### Default Rule {#default-rule}

[:octicons-tag-24: Version-1.6.0](dataway-changelog.md#cl-1.6.0)

By adding the `as_default` identifier in a specific rule entry, that rule can be set as the default fallback rule. The fallback rule can omit any matching conditions (no `rules` field configured); it should not participate in regular rule matching. A suggested fallback rule is as follows:

``` json hl_lines="2"
{
    "as_default": true,
    "info": "This is the default fallback workspace",
    "url": "https://kodo.guance.com?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

> Note: Only one fallback rule should be set. If multiple fallback rules exist in the sinker configuration, the last one takes precedence.

### Token Rules {#spec-on-secret-token}

Since Datakit checks the token on Dataway, the `token` (including `secret_token`) set here must meet the following conditions:

> Start with `token_` or `tkn_`, followed by characters of length 32.

For tokens that do not meet this condition, Datakit installation will fail.

## Datakit End Configuration {#config-dk}

In Datakit, several configurations need to be made to tag the collected data for grouping.

- Configure Global Custom Key List

Datakit will look for fields with these keys in the collected data (only string-type fields) and extract them as the basis for grouped sending.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Refer to [here](../datakit/datakit-install.md#env-sink)

=== "Kubernetes"

    Refer to [here](../datakit/datakit-daemonset-deploy.md#env-sinker)
<!-- markdownlint-enable -->

- Configure "Global Host Tag" and "Global Election Tag"

All Datakit uploaded data will carry these global tags (including tag key and tag value) as the basis for grouped sending.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Refer to [here](../datakit/datakit-install.md#common-envs)

=== "Kubernetes"

    Refer to [here](../datakit/datakit-daemonset-deploy.md#env-common)
<!-- markdownlint-enable -->

### Datakit End Customer Key Configuration {#dk-customer-key}

To ensure that the data collected by a specific Datakit meets the routing requirements, ensure the following points:

- Datakit has enabled the Sinker feature
- Datakit has configured valid Global Customer Keys

These configurations are as follows:

```toml
# /usr/local/datakit/conf.d/datakit.conf
[dataway]

  # Specify a set of customer keys
  global_customer_keys = [
    # Example: Add category and class two keys
    # It is not advisable to configure too many keys, usually 2 ~ 3 is enough
    "category",
    "class",
  ]

  # Enable sinker function
  enable_sinker = true
```

Apart from Synthetic Tests data and [regular data categories](../datakit/apis.md#category), it also supports [Session Replay](../integrations/rum.md#rum-session-replay) and [Profiling](../integrations/profile.md) binary file data. Therefore, all field names can be chosen here, but **non-string type fields should not be configured**. Normal keys generally come from Tags (all Tag values are string types). Datakit will not use non-string type fields as routing criteria.

#### Impact of Global Tags {#dk-global-tags-on-sink}

Besides `global_customer_keys`, the [global Tags](../datakit/datakit-conf.md#set-global-tag) configured on Datakit (including global election Tags and global host Tags) also affect the routing tags. That is, if the data point contains fields that appear in the global Tags (these field values must be string types), they will be counted towards routing. Assuming the global election Tags are as follows:

```toml
# datakit.conf
[election.tags]
    cluster = "my-cluster"
```

For the following data point:

```not-set
pi,cluster=cluster_A,app=math,other_tag=other_value value=3.14 1712796013000000000
```

Since the global election Tags contain `cluster` (regardless of the value configured for this Tag), and the point itself also has a `cluster` Tag, in the final `X-Global-Tags`, `cluster=cluster_A` will be appended:

```not-set
X-Global-Tags: cluster=cluster_A
```

If `global_customer_keys` also configures the `app` key, then the final routing Header would be (the order of the key-value pairs is not important):

```not-set
X-Global-Tags: cluster=cluster_A,app=math
```

<!-- markdownlint-disable MD046 -->
???+ note

    This example intentionally sets the `cluster` value in *datakit.conf* differently from the `cluster` field value in the data point, mainly to emphasize the impact of the Tag Key. You can understand that once a data point contains a global Tag Key, **its effect is equivalent to adding this global Tag Key to `global_customer_keys`**.
<!-- markdownlint-enable -->

## Dataway Sink Commands {#dw-sink-command}

Starting from version [:octicons-tag-24: Version-1.3.6](dataway-changelog.md#cl-1.3.6), Dataway supports managing `sinker` configurations via the command line. Specific usage is as follows:

```shell
$ ./dataway sink --help

Usage of sink:
  -add string
        single rule json file
  -cfg-file string
        configure file (default "/usr/local/cloudcare/dataflux/dataway/dataway.yaml")
  -file string
        file path of the rule json, only used for commands put and get
  -get
        get the rule json
  -list
        list rules
  -log string
        log file path (default "/dev/null")
  -put
        save the rule json
  -token string
        rules filtered by token, eg: xx,yy
```

**Specifying Configuration File**

By default, the command loads the configuration file `/usr/local/cloudcare/dataflux/dataway/dataway.yaml`. To load other configurations, specify it using `--cfg-file`.

```shell
$ ./dataway sink --cfg-file dataway.yaml [--list...]
```

**Command Log Setting**

By default, command output logs are disabled. To view logs, set the `--log` parameter.

```shell
# Output log to stdout
$ ./dataway sink --list --log stdout

# Output log to file
$ ./dataway sink --list --log /tmp/log
```

**Viewing Rule List**

```shell

# List all rules
$ ./dataway sink --list

# List all rules filtered by token
$ ./dataway sink --list --token=token1,token2

CreateRevision: 2
ModRevision: 41
Version: 40
Rules:
[
    {
        "rules": [
            "{ workspace = 'zhengb-test'}"
        ],
        "url": "https://openway.guance.com?token=token1"
    }
]
```

**Adding Rules**

Create a rule file `rule.json` with the following content:

```json
[
  {
    "rules": [
      "{ host = 'HOST1'}"
    ],
    "url": "https://openway.guance.com?token=tkn_xxxxxxxxxxxxx"
  },
  {
    "rules": [
      "{ host = 'HOST2'}"
    ],
    "url": "https://openway.guance.com?token=tkn_yyyyyyyyyyyyy"
  }
]

```

Add rules

```shell
$ ./dataway sink --add rule.json

add 2 rules ok!

```

**Export Configuration**

Exporting configuration can export the `sinker` configuration to a local file.

```shell
$ ./dataway sink --get --file sink-get.json

rules json was saved to sink-get.json!

```

**Writing Configuration**

Write the local rule file to `sinker`.

Create a rule file `sink-put.json` with the following content:

```json
{
    "rules": [
        {
            "rules": [
                "{ workspace = 'test'}"
            ],
            "url": "https://openway.guance.com?token=tkn_xxxxxxxxxxxxxx"
        }
    ],
    "strict": true
}

```

Write configuration

```shell
$ ./dataway sink --put --file sink-put.json
```

## Configuration Examples {#config-examples}

<!-- markdownlint-disable MD046 -->
??? info "Example of dataway.yaml in Kubernetes (expand to view)"

    Directly specify sinker JSON in yaml:


    ```yaml
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: deployment-utils-dataway
      name: dataway
      namespace: utils
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: deployment-utils-dataway
      template:
        metadata:
          labels:
            app: deployment-utils-dataway
          annotations:
            datakit/logs: |
              [{"disable": true}]
            datakit/prom.instances: |
              [[inputs.prom]]
                url = "http://$IP:9090/metrics" # Port (default 9090) depends on circumstances
                source = "dataway"
                measurement_name = "dw" # Fixed as this metric set
                interval = "10s"

                [inputs.prom.tags]
                  namespace = "$NAMESPACE"
                  pod_name = "$PODNAME"
                  node_name = "$NODENAME"
        spec:
          affinity:
            podAffinity: {}
            podAntiAffinity:
              requiredDuringSchedulingIgnoredDuringExecution:
                - labelSelector:
                    matchExpressions:
                      - key: app
                        operator: In
                        values:
                          - deployment-utils-dataway
                  topologyKey: kubernetes.io/hostname

          containers:
          - image: registry.jiagouyun.com/dataway/dataway:1.3.6 # Choose appropriate version number
            #imagePullPolicy: IfNotPresent
            imagePullPolicy: Always
            name: dataway
            env:
            - name: DW_REMOTE_HOST
              value: "http://kodo.forethought-kodo:9527" # Fill in the real Kodo address or the next Dataway address
            - name: DW_BIND
              value: "0.0.0.0:9528"
            - name: DW_UUID
              value: "agnt_xxxxx" # Fill in the real Dataway UUID
            - name: DW_TOKEN
              value: "tkn_oooooooooooooooooooooooooooooooo" # Fill in the real Dataway token, generally the system workspace token
            - name: DW_PROM_LISTEN
              value: "0.0.0.0:9090"
            - name: DW_SECRET_TOKEN
              value: "tkn_zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
            - name: DW_SINKER_FILE_PATH
              value: "/usr/local/cloudcare/dataflux/dataway/sinker.json"
            ports:
            - containerPort: 9528
              name: 9528tcp01
              protocol: TCP
            volumeMounts:
              - mountPath: /usr/local/cloudcare/dataflux/dataway/cache
                name: dataway-cache
              - mountPath: /usr/local/cloudcare/dataflux/dataway/sinker.json
                name: sinker
                subPath: sinker.json
            resources:
              limits:
                cpu: '4'
                memory: 4Gi
              requests:
                cpu: 100m
                memory: 512Mi
          # nodeSelector:
          #   key: string
          imagePullSecrets:
          - name: registry-key
          restartPolicy: Always
          volumes:
          - hostPath:
              path: /root/dataway_cache
            name: dataway-cache
          - configMap:
              name: sinker
            name: sinker
    ---

    apiVersion: v1
    kind: Service
    metadata:
      name: dataway
      namespace: utils
    spec:
      ports:
      - name: 9528tcp02
        port: 9528
        protocol: TCP
        targetPort: 9528
        nodePort: 30928
      selector:
        app: deployment-utils-dataway
      type: NodePort

    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: sinker
      namespace: utils
    data:
      sinker.json: |
        {
            "strict":true,
            "rules": [
                {
                    "rules": [
                        "{ project = 'xxxxx'}"
                    ],
                    "url": "http://kodo.forethought-kodo:9527?token=tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                },
                {
                    "rules": [
                        "{ project = 'xxxxx'}"
                    ],
                    "url": "http://kodo.forethought-kodo:9527?token=tkn_yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
                }
             ]
        }
    ```

<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
??? info "Ingress Configuration Example (expand to view)"

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: dataway-sinker
      namespace: utils
    spec:
      ingressClassName: nginx
      rules:
      - host: datawaysinker-xxxx.com
        http:
          paths:
          - backend:
              service:
                name: dataway
                port:
                  number: 9528
            path: /
            pathType: ImplementationSpecific
    ```

<!-- markdownlint-enable -->

## FAQ {#faq}

### Viewing Details of Dropped Requests {#dropped-request}

[:octicons-tag-24: Version-1.3.7](dataway-changelog.md#cl-1.3.7)

When a request does not match the Sinker rules, Dataway discards the request and increments a discard count in metrics. During debugging, we need to know the specifics of a dropped request, especially the `X-Global-Tags` information carried in the request headers.

We can search the Dataway logs using the following command:

``` bash
$ cat <path/to/dataway/log> | grep dropped
```

In the output results, you can see something like the following:

``` not-set
for API /v1/write/logging with X-Global-Tags <some-X-Global-Tags...> dropped
```

### Troubleshooting Datakit Request Discard {#dk-http-406}

[:octicons-tag-24: Version-1.3.9](dataway-changelog.md#cl-1.3.9)

When a Datakit request is discarded by Dataway, Dataway returns the corresponding HTTP error. In the Datakit logs, there will be an error similar to the following:

```not-set
post 3641 to http://dataway-ip:9528/v1/write/metric failed(HTTP: 406 Not Acceptable):
{"error_code":"dataway.sinkRulesNotMatched","message":"X-Global-Tags: `host=my-host',
URL: `/v1/write/metric'"}, data dropped
```

This error indicates that the request `/v1/write/metric` was discarded because its X-Global-Tags did not satisfy any of the Dataway rules.

Additionally, in the Datakit monitor (`datakit monitor -V`), in the `DataWay APIs` panel at the bottom right, the `Status` column will show `Not Acceptable`, indicating that the corresponding Dataway API request was discarded.

You can also check the Datakit metrics to see the corresponding metrics:

```shell
$ curl -s http://localhost:9529/metrics | grep datakit_io_dataway_api_latency_seconds_count

datakit_io_dataway_api_latency_seconds_count{api="/v1/datakit/pull",status="Not Acceptable"} 50
datakit_io_dataway_api_latency_seconds_count{api="/v1/write/metric",status="Not Acceptable"} 301
```

### Datakit Error 403 {#dk-403}

If the Dataway sinker configuration is incorrect, leading all Datakit requests to use `secret_token`, and this token is not recognized by the center (Kodo), hence reporting a 403 error `kodo.tokenNotFound`.

This issue might be caused by incorrect etcd username/password, preventing Dataway from obtaining the Sinker configuration, causing Dataway to consider the current sinker invalid and directly transmit all data to the center.

### etcd Permission Configuration Issues {#etcd-permission}

If the Dataway logs contain the following error, it indicates a possible permission setting issue:

```not-set
sinker ping: etcdserver: permission denied, retrying(97th)
```

If the permission configuration is improper, you can delete all existing Dataway-based permissions and reconfigure them. Refer to [here](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#using-etcdctl-to-authenticate){:target="_blank"}

### Priority of Keys on the Datakit End {#key-priority}

When configuring the "Global Custom Key List," if the "Global Host Tag" and "Global Election Tag" also have the same named Key, the corresponding Key-Value pair from the collected data is used.

For example, if the "Global Custom Key List" includes `key1,key2,key3`, and the "Global Host Tag" or "Global Election Tag" also configures these Keys with corresponding values, such as `key1=value-1`, and in some data collection, there is also a field `key1=value-from-data`, then the final grouping basis uses the `key1=value-from-data` from the data, ignoring the corresponding Key Value configured in the "Global Host Tag" and "Global Election Tag".

If there are the same named Keys between the "Global Host Tag" and "Global Election Tag", the Key from the "Global Election Tag" takes precedence. In summary, the priority of Key value sources (in descending order) is as follows:

- Collected data
- Global Election Tag
- Global Host Tag

### Built-in "Global Custom Keys" {#reserved-customer-keys}

Datakit includes several built-in custom Keys that generally do not appear in the collected data but can be used by Datakit to group data. If there is a need to split data based on these Keys, they can be added to the "Global Custom Key" list (these Keys are not configured by default). We can use the following built-in custom Keys to implement data splitting.

<!-- markdownlint-disable MD046 -->
???+ warning

    Adding "Global Custom Keys" can lead to data being sent in separate packages during transmission. If the granularity is too fine, it can drastically reduce the efficiency of Datakit uploads. Generally, the "Global Custom Keys" should not exceed 3.
<!-- markdownlint-enable -->

- `class` targets object data. When enabled, it splits data based on the classification of objects. For example, the object classification for Pod is `kubelet_pod`, so rules can be formulated for Pods:

``` json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ class = 'kubelet_pod' AND other_conditon = 'some-value' }",
            ],
            "url": "https://openway.guance.com?token=<YOUR-TOKEN>"
        },
        {
            ... # other rules
        }
    ]
}
```

- `measurement` targets metric data. We can send specific metrics to specific workspaces. For example, if the metric set name for disk is `disk`, we can write the rule as follows:

```json
{
    "strict": true,
    "rules": [
        {
           "rules": [
               "{ measurement = 'disk' AND other_conditon = 'some-value' }",
           ],
           "url": "https://openway.guance.com?token=<YOUR-TOKEN>"
        },
        {
            ... # other rules
        }
    ]
}
```

- `source` targets logs (L), eBPF network metrics (N), events (E), and RUM data.
- `service` targets Tracing, Synthetic Tests, and Profiling.
- `category` targets all [standard data categories](../datakit/apis.md#category), with its value being the "name" column of the corresponding data category (such as `metric` for time series, `object` for objects, etc.). Taking logs as an example, we can write the splitting rule as follows:

``` json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ category = 'logging' AND other_conditon = 'some-value' }",
            ],
            "url": "https://openway.guance.com?token=<YOUR-TOKEN>"
        },
        {
            ... # other rules
        }
    ]
}
```

### Special Splitting Behavior {#special-sink-rule}

Some requests initiated by Datakit aim to pull resources from the center or perform identity recognition. These actions are atomic and indivisible, and cannot be distributed to multiple workspaces (because Datakit needs to handle the return of these API requests and decide subsequent behavior). Therefore, these APIs can only be routed to one workspace.

If multiple conditions are met in the splitting rules, these APIs will **only be routed to the first workspace specified by the rule that satisfies the condition**.

Here is an example of such routing rules:

> We recommend adding the following rule in the Sinker rules to ensure that Datakit's existing API requests are assigned to a specific workspace.

``` json
{
    "strict": true,
    "info": "Special workspace (only for data pulling and other APIs)",
    "rules": [
        {
            "rules": [
                "{ __dataway_api in ['/v1/datakit/pull', '/v1/election', '/v1/election/heartbeat', '/v1/query/raw', '/v1/workspace', '/v1/object/labels', '/v1/check/token'] }",
            ],
            "url": "https://openway.guance.com?token=<SOME-SPECIAL-WORKSPACE-TOKEN>"
        }
    ]
}
```

<!-- markdownlint-disable MD046 -->
???+ info

    Explanation of these API URLs:
        
    - `/v1/election`: Election request
    - `/v1/election/heartbeat`: Election heartbeat request
    - `/v1/datakit/pull`: Pull Pipeline and blacklist configurations from the center
    - `/v1/query/raw`: DQL query
    - `/v1/workspace`: Get workspace information
    - `/v1/object/labels`: Update/delete object data
    - `/v1/check/token`: Check workspace Token information
<!-- markdownlint-enable -->

Here, the key `__dataway_api` does not need to be configured in the `global_customer_keys` in *datakit.conf*. By default, Dataway treats this as a routing key, using the current request's API route as its value. That is, for a certain API:

```text
POST /v1/some/api
X-Global-Tags: cluster=cluster_A,app=math
```

Its final routing effect is the same as:

```text
POST /v1/some/api
X-Global-Tags: cluster=cluster_A,app=math,__dataway_api=/v1/write/metrics
```

Therefore, we can directly use the `__dataway_api` KV pair in the Sink rule for matching. This also reminds us that in this special rule, **do not include other important data upload APIs**, such as `/v1/write/...`, otherwise, which space the data ends up in is undefined.