
# Dataway Sink
---

[:octicons-tag-24: Version-1.14.0](../datakit/changelog.md#cl-1.14.0) to use the sinker functionality here.

---

## Dataway Sinker Function Introduction {#sink-intro}

In the daily data collection process, we may need to upload different data into different workspaces due to the existence of multiple different workspaces. For example, in a common Kubernetes cluster, the data collected may involve different teams or business departments, and we can tap the data with specific attributes to different workspaces to achieve fine-grained collection in common infrastructure scenarios.

The basic network topology is as follows:

```mermaid
flowchart TD
dw(Dataway);
dk(Datakit);
etcd[(etcd)];
sinker(Sinker);
wksp1(Workspace 1);
wksp2(Workspace 2);
rules(Sinker Rules);
check_token{Token ok?};
drop(Drop Data/Request);

subgraph "Datakit cluster"
dk
end

dk -.-> |HTTP: X-Global-Tags/Secret-Token|dw

subgraph "Dataway Cluster (Nginx)"
%%direction LR
rules -->  dw
dw --> check_token -->|No| drop
check_token -->|OK| sinker

sinker --> |Rule 1 match|wksp1;
sinker --> |Rule 2 match|wksp2;
sinker --> |Rules do not match|drop;
end

subgraph "Workspace Changes"
direction BT
etcd -.-> |Key change notice|rules
end
```

### Dataway Serial Mode {#cascaded}

For SaaS users, you can deploy a Dataway on your own premises (k8s cluster) dedicated to offloading, and then forward the data to Openway:

<!-- markdownlint-disable MD046 -->
???+ attention

    In cascaded mode, the Dataway in the cluster needs to enable the `cascaded` option. See [Environment Variable Description](dataway.md#dw-envs) in the installation documentation. 
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
etcd-.-> | triage rules | sink_dw
end

subgraph "SaaS"
sink_dw --> |Sink|openway;
sink_dw --> |Sink|openway;
end
```

## etcd settings {#etcd-settings}

<!-- markdownlint-disable MD046 -->
=== "etcd settings already exist"

    Dataway, as an etcd client, can set the following username and role in etcd (etcd 3.5+), see [here](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#using-etcdctl-to-authenticate){:target="_blank"}

    Create a 'dataway' account and corresponding role:

    ```shell
    # Add a username, where you will be prompted for a password
    $ etcdctl user add dataway 

    # Add the role of sinker
    $ etcdctl role add sinker 

    # Add Dataway to the role
    $ etcdctl user grant-role dataway sinker

    # Restrict the key permissions of the role (where /dw_sinker and /ping are the two keys used by default)
    $ etcdctl role grant-permission sinker readwrite /dw_sinker
    $ etcdctl role grant-permission sinker readwrite /ping # is used to detect connectivity
    ```

=== "Kubernetes self-built etcd node"

    See [here](https://github.com/etcd-io/etcd/tree/main/hack/kubernetes-deploy){:target="_blank"}.

???+ info "Why create a role?"

    Roles are used to control the permissions of the corresponding user on certain keys, here we may use the user's existing etcd service, it is necessary to restrict the data permissions of Dataway this user.

???+ attention

    If etcd has [authentication mode](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#enabling-authentication){:target="_blank"} enabled, execute the `etcdctl` command, and bring the corresponding username and password:

    ```shell
    $ etcdctl --user name:password ...
    ```
<!-- markdownlint-enable -->

### Write sinker rules {#prepare-sink-rules}

Suppose the *sinker.json* rule is defined as follows:

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

You can write the sinker rule configuration with the following command:

```shell
$ etcdctl --user dataway:PASSWORD put /dw_sinker "$(<sinker.json)"
OK
```

<!-- markdownlint-disable MD046 -->
???+ tip "Comment URL Token Info"

    Because we can't add comments on JSON file *sinker.json*, we can add extra field for commenting:

    ``` json
    {
        "rules": [
            "{ host = 'my-host' OR cluster = 'cluster-A' }"
        ],
        "info": "This is yyy workspace",
        "url": "https://kodo.guance.com?token=tkn_yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
    }
    ```
<!-- markdownlint-enable -->

## Dataway installation {#dw-install}

See [here](dataway.md#install)

## Dataway sink command {#dw-sink-command}

Dataway supports managing the configuration of `sinker` through the command line since version [:octicons-tag-24: Version-1.3.6](dataway-changelog.md#cl-1.3.6). The specific usage is as follows:

```shell
$ ./dataway sink --help

Usage of sink:
  -add string
    	single rule json file
  -cfg-file string
    	configure file (default "/usr/local/cloudcare/dataflux/dataway/dataway.yaml")
  -file string
    	file path of the rule json, only used for command put and get
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

**Specify configuration file**

When the command is executed, the default configuration file loaded is `/usr/local/cloudcare/dataflux/dataway/dataway`.yaml, and if additional configurations need to be loaded, they can be specified using the `--cfg-file` option.

```shell
$ ./dataway sink --cfg-file dataway.yaml [--list...]
```

**Command log setting**

The command log was disabled by default. If you need to view it, you can set the `--log` parameter.

```shell
# output log to stdout
$ ./dataway sink --list --log stdout

# output log to file
$ ./dataway sink --list --log /tmp/log
```

**View sinker rules**

```shell

# list all rules 
$ ./dataway sink --list

# list all rules filtered by token 
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

**Add sinker rules**

Create file `rule.json` and add the following content:

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

Add the rules.

```shell
$ ./dataway sink --add rule.json

add 2 rules ok!

```

**Export sinker configuration**

Export the `sinker` configuration content to local file.

```shell
$ ./dataway sink --get --file sink-get.json

rules json was saved to sink-get.json!

```

**Import sinker configuration**

Import `sinker` configuration from local file.

Create file `sink-put.json` and add following content:

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

Import the file.

```shell
$ dataway sink --put --file sink-put.json
```

## Dataway Settings {#dw-config}

In addition to the general Dataway settings, several additional configurations need to be set up (located in the */usr/local/cloudcare/dataflux/dataway/* directory):

```yaml
# Set the address to be uploaded by Dataway here, usually Kodo, but it can also be another Dataway
remote_host: https://kodo.guance.com

# If the upload address is Dataway, set to true here to indicate that Dataway cascade
cascaded: false

# This token is a random token set on the dataway, we need to fill it in
# Datakit's datakit.conf configuration. A certain length and format need to be maintained here.
secret_token: tkn_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# sinker rule settings
sinker:
  etcd: # supports etcd
    urls:
    - http://localhost:2379
    dial_timeout: 30s
    key_space: /dw_sinker
    username: "dataway"
    password: "<PASSWORD>"

  #file: # also supports local file mode, which is often used for debugging
  #  path: /path/to/sinker.json
```

<!-- markdownlint-disable MD046 -->
???+ attention

    If you do not set `secret_token`, any request sent by Datakit will go through without causing data problems. However, if Dataway is deployed on the public network, it is recommended to set `secret_token`.

    If etcd does not set a username/password, then set both `username` and `password` to `""` here.
<!-- markdownlint-enable -->

## Token Specs {#spec-on-secret-token}

Since Datakit will detect tokens on Dataway, the `token` (including `secret_token`) set here must meet the following conditions:

> starts with `token_` or `tkn_` and follows a character length of 32.

For tokens that do not meet this condition, Datakit fails to install.

## Datakit-side settings {#config-dk}

In Datakit, we need to make several settings so that it can group the collected data with specific tags.

- Configure a global custom key list

Datakit looks for fields with these keys (only string-type fields) in the data it collects, and extracts them as a basis for grouping.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    See [here](../datakit/datakit-install.md#env-sink)

=== "Kubernetes"

    See [here](../datakit/datakit-daemonset-deploy.md#env-sinker)
<!-- markdownlint-enable -->

- Configure Global Host Tag and Global Election Tag

In all Datakit uploaded data, these configured global tags (including tag key and tag value) will be brought as the basis for group sending.

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    See [here](../datakit/datakit-install.md#common-envs)

=== "Kubernetes"

    See [here](../datakit/datakit-daemonset-deploy.md#env-common)
<!-- markdownlint-enable -->

## Data range covered by sinker {#coverage}

In addition to dial tests, [General Data Classification](../datakit/apis.md#category), [Session Replay](../integrations/rum.md#rum-session-replay) and [Profiling](../integrations/profile.md) and other binary file data.

## FAQ {#faq}

### Datakit Error 403 {#dk-403}

If the sinker on the Dataway is misconfigured, causing all Datakit requests to use `secret_token`, and the token hub (Kodo) is not recognized, a 403 error `kodo.tokenNotFound` is reported.

The cause of this problem may be that the etcd username and password are wrong, causing Dataway to fail to obtain the sinker configuration, and Dataway believes that the current sinker is invalid, and all data is directly transmitted to the center.

### etcd permission configuration issues {#etcd-permission}

If the following error is reported in the Dataway log, there may be a problem with the permission setting:

```not-set
sinker ping: etcdserver: permission denied, retrying(97th)
```

If the permissions are not configured properly, you can delete all existing Dataway-based permissions and reconfigure them, see [here](https://etcd.io/docs/v3.5/op-guide/authentication/rbac/#using-etcdctl-to-authenticate){:target="_blank"}

### Datakit Key Priority {#key-priority}

When configuring the Global Custom Key List, if both the Global Host Tag and the Global Election Tag also have a Key with the same name, the corresponding Key-Value pair in the collected data is used.

For example, if there is `key1,key2,key3` in the configured "global custom key list", and these keys are also configured in the "global host tag" or "global election tag" and the corresponding values are specified, such as: `key1=value-1`, in a data collection, there is also a field `key1=value-from-data`, then the final grouping by uses `key1=in the data` value-from-data', ignoring the value of the corresponding key configured in the Global Host Tag and Global Election Tag.

If there is a key with the same name between the Global Host Tag and the Global Election Tag, the key in the Global Election Tag takes precedence. In summary, the value source priority of the key is as follows (decreasing):

- Data collected
- Global election tag
- Global host TAg

### Built-in "global custom key" {#reserved-customer-keys}

Datakit has several built-in custom keys that are not typically present in the collected data, but Datakit can use these keys to group data. If there is a need to split the dimensions of these keys, you can add them to the "Global Custom Key" list (none of these keys are configured by default). We can use some built-in custom keys as follows to achieve data offloading.

<!-- markdownlint-disable MD046 -->
???+ attention

    The addition of a "global custom key" will cause data to be subpackaged when it is sent, and if the granularity is too fine, the Datakit upload efficiency will be rapidly reduced. In general, it is not recommended to have more than 3 global custom keys.
<!-- markdownlint-enable -->

- `class` is for object data, and when enabled, it will be divided according to the classification of objects. For example, if the object of a pod is classified as `kubelet_pod`, then you can formulate a triage rule for the pod:

``` json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ class = 'kubelet_pod' AND other_conditon = 'some-value' }",
            ],
            "url": "https://openway.guance.com?token=<YOUR-TOKEN>",
        },
        {
            ... # other rules
        }
    ]
}
```

- `measurement` For indicator data, we can hit a specific indicator set to a specific workspace, for example, the name of the indicator set on disk is `disk`, we can write the rule like this:

```json
{
    "strict": true,
    "rules": [
        {
           "rules": [
               "{ measurement = 'disk' AND other_conditon = 'some-value' }",
           ],
           "url": "https://openway.guance.com?token=<YOUR-TOKEN>",
        },
        {
            ... # other rules
        }
    ]
}
```

- `source` for logs (L), eBPF network metrics (N), events (E), and RUM data
- `service` for Tracing, Scheck, and Profiling
- `category` for all [general data classification](apis.md#category), its value is the "name" column of the corresponding data classification (e.g. time series is `metric`, object is `object`, etc.). Taking logs as an example, we can do a separate triage rule for logs as follows:

``` json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ category = 'logging' AND other_conditon = 'some-value' }",
            ],
            "url": "https://openway.guance.com?token=<YOUR-TOKEN>",
        },
        {
            ... # other rules
        }
    ]
}
```

- `__dataway_api` can be routed for a specific API, and the specified rule can be applied to that request. For example, a synchronous request and an election request for Pipeline (the election function involves two API calls):

``` json
{
    "strict": true,
    "rules": [
        {
            "rules": [
                "{ __dataway_api in ['/v1/datakit/pull', '/v1/election', '/v1/election/heartbeat'] }",
            ],
            "url": "https://openway.guance.com?token=<YOUR-TOKEN>",
        }
    ]
}
```
