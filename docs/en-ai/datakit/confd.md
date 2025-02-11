# Distributing Configuration via the Configuration Center
---

## Introduction to the Configuration Center {#intro}

The idea behind the configuration center is to centralize all configurations, parameters, and switches from various projects into one unified management system, providing a standardized set of interfaces. When services need to retrieve configurations, they pull from the configuration center's interface. When there are updates to parameters in the configuration center, it can notify services to synchronize the latest information in real-time, enabling dynamic updates.

Using "centralized configuration management" effectively addresses the traditional problem of "configuration files being too scattered." All configurations are managed in one place at the configuration center, eliminating the need for each project to have its own configuration file, significantly reducing development costs.

By separating "configuration from application," it effectively solves the traditional issue of "configuration files not distinguishing between environments." Configurations do not follow the environment; when different environments have different requirements, they can obtain the necessary configurations from the configuration center, greatly reducing deployment and maintenance costs.

The "real-time update" feature addresses the problem of traditional "static configurations." When online systems need parameter adjustments, they can be dynamically modified in the configuration center.

Datakit supports multiple configuration centers such as `etcd-v3`, `consul`, `redis`, `zookeeper`, `aws secrets manager`, `nacos`, `file`, etc., and can use multiple configuration centers simultaneously. When data in the configuration center changes, Datakit can automatically update configurations, add or remove collectors, and restart relevant collectors as needed.

## Introducing the Configuration Center {#Configuration-Center-Import}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Datakit introduces configuration center resources by modifying `/datakit/conf.d/datakit.conf`. For example:

    ```
    # Other existing configuration information
    [[confds]]
      enable = true
      backend = "zookeeper"
      nodes = ["IP:2181","IP2:2181"...]
    [[confds]]
      enable = true
      backend = "etcdv3"
      nodes = ["IP:2379","IP2:2379"...]
      # client_cert = "optional"
      # client_key = "optional"
      # client_ca_keys = "optional"
      # basic_auth = "optional"
      # username = "optional"
      # password = "optional"
    [[confds]]
      enable = true
      backend = "redis"
      nodes = ["IP:6379","IP2:6379"...]
      # client_key = "optional"
      # separator = "optional|default is 0"
    [[confds]]
      enable = true
      backend = "consul"
      nodes = ["IP:8500","IP2:8500"...]
      # scheme = "optional"
      # client_cert = "optional"
      # client_key = "optional"
      # client_ca_keys = "optional"
      # basic_auth = "optional"
      # username = "optional"
      # password = "optional"
    [[confds]]
      enable = true
      backend = "aws"
      region = "cn-north-1"
      # Access key ID    : must use the key file /root/.aws/config or ENV
      # Secret access key: must use the key file /root/.aws/config or ENV
      circle_interval = 60
    [[confds]]
      enable = true
      backend = "nacos"
      nodes = ["http://IP:8848","https://IP2:8848"...]
      # username = "optional"
      # password = "optional"
      circle_interval = 60 
      confd_namespace =    "confd namespace ID"
      pipeline_namespace = "pipeline namespace ID"
    # Other existing configuration information
    ```
    ???+ attention

        If multiple configuration center backends are configured, only the first configuration will take effect.

=== "Kubernetes"

    Due to the special nature of Kubernetes environments, using environment variables for installation/configuration is the simplest method.

    When installing in Kubernetes, you need to set the following environment variables to pass the configuration information. Refer to the [Kubernetes documentation](datakit-daemonset-deploy.md#env-confd).

=== "Program Installation"

    If you need to define some Datakit configurations during the installation phase, you can add environment variables before the installation command. For example:

    ```shell
    # Linux/Mac
    DK_CONFD_BACKEND=etcd3 DK_CONFD_BACKEND_NODES=[127.0.0.1:2379] DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"

    # Windows
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_CONFD_BACKEND="etcd3";
    $env:DK_CONFD_BACKEND_NODES="[127.0.0.1:2379]";
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```

    The format for setting environment variables is:

    ```shell
    # Windows: Multiple environment variables are separated by semicolons
    $env:NAME1="value1"; $env:Name2="value2"

    # Linux/Mac: Multiple environment variables are separated by spaces
    NAME1="value1" NAME2="value2"
    ```

    Refer to the [host installation documentation](datakit-install.md#env-confd) for more details.

<!-- markdownlint-enable -->

## Default Enabled Collectors {#default-enabled-inputs}
After installing DataKit, a batch of host-related collectors are enabled by default without manual configuration, such as `cpu`, `disk`, `diskio`, `mem`, etc. Refer to [Collector Configuration](datakit-input-conf.md#default-enabled-inputs)

The configuration center can modify these collector configurations but cannot delete or stop them. To delete default collectors, open the *datakit.conf* file under the Datakit *conf.d* directory and remove the collector from `default_enabled_inputs`.

## Singleton Operation Control for Collectors {#input-singleton}

Some collectors are allowed to run only as singletons, such as all default enabled collectors and `netstat`. Others can run multiple instances, such as `nginx` and `nvidia_smi`.

For singleton-running collector configurations, only the first loaded configuration takes effect (sorted by filename).

## Data Format {#data-format}

Datakit configuration information is stored in the configuration center in Key-Value form. The key prefix must be `/datakit/`, for example, `/datakit/XXX`, where `XXX` should be unique. It is recommended to use the corresponding collector name, such as `/datakit/netstat`.

The value content is the complete content of various configuration files in the *conf.d* subdirectory. For example:

```toml
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
```

In file mode, the file content is the original *.conf* file content.

## How the Configuration Center Updates Configuration (Example in Golang) {#update-config}

### Zookeeper {#update-zookeeper}

```golang
import (
    "github.com/samuel/go-zookeeper/zk"
)

func zookeeperDo(index int) {
    hosts := []string{ip + ":2181"}
    conn, _, err := zk.Connect(hosts, time.Second*5)
    if err != nil {
        fmt.Println("conn, _, err := zk.Connect error: ", err)
    }
    defer conn.Close()
    // Create top-level directory node
    add(conn, "/datakit", "")
    // Create second-level directory nodes
    add(conn, "/datakit/confd", "")
    add(conn, "/datakit/pipeline", "")
    // Create third-level directory nodes
    add(conn, "/datakit/pipeline/metrics", "")
    add(conn, "/datakit/pipeline/metric", "")
    add(conn, "/datakit/pipeline/network", "")
    add(conn, "/datakit/pipeline/keyevent", "")
    add(conn, "/datakit/pipeline/object", "")
    add(conn, "/datakit/pipeline/custom_object", "")
    add(conn, "/datakit/pipeline/logging", "")
    add(conn, "/datakit/pipeline/tracing", "")
    add(conn, "/datakit/pipeline/rum", "")
    add(conn, "/datakit/pipeline/security", "")
    add(conn, "/datakit/pipeline/profiling", "")
    // Create a node
    key := "/datakit/confd/netstat.conf"
    value := `
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
`
    add(conn, key, value)
}

func add(conn *zk.Conn, path, value string) {
    if path == "" {
        return
    }

    var data = []byte(value)
    var flags int32 = 0
    acls := zk.WorldACL(zk.PermAll)
    s, err := conn.Create(path, data, flags, acls)
    if err != nil {
        fmt.Println("create error: ", err)
        modify(conn, path, value)
        return
    }
    fmt.Println("created successfully", s)
}

func modify(conn *zk.Conn, path, value string) {
    if path == "" {
        return
    }
    var data = []byte(value)
    _, state, _ := conn.Get(path)
    s, err := conn.Set(path, data, state.Version)
    if err != nil {
        fmt.Println("modify error: ", err)
        return
    }
    fmt.Println("modified successfully", s)
}
```

### etcd-v3 {#update-etcdv3}

``` golang
import (
    etcdv3 "go.etcd.io/etcd/client/v3"
)

func etcdv3Do(index int) {
    cli, err := etcdv3.New(etcdv3.Config{
        Endpoints:   []string{ip + ":2379"},
        DialTimeout: 5 * time.Second,
    })
    if err != nil {
        fmt.Println("error: ", err)
    }
    defer cli.Close()
    key := "/datakit/confd/host/netstat.conf"
    // key := "/datakit/pipeline/metric/netstat.p"
    value := `
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
`

    // put
    ctx, cancel := context.WithTimeout(context.Background(), time.Second)
    _, err = cli.Put(ctx, key, value)
    cancel()
    if err != nil {
        fmt.Println("error: ", err)
    }
}
```

### Redis {#update-redis}

``` golang
import (
    "github.com/go-redis/redis/v8"
)

func redisDo(index int) {
    // Initialize context
    ctx := context.Background()

    // Initialize Redis client
    rdb := redis.NewClient(&redis.Options{
        Addr:     ip + ":6379",
        Password: "654123", // no password set
        DB:       0,        // use default DB
    })

    // Operate on Redis
    key := "/datakit/confd/host/netstat.conf"
    value := `
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
`

    err := rdb.Set(ctx, key, value, 0).Err()
    if err != nil {
        panic(err)
    }

    // Publish/subscribe
    n, err := rdb.Publish(ctx, "__keyspace@0__:/datakit*", "set").Result()
    if err != nil {
        fmt.Println(err)
        return
    }
    fmt.Printf("%d clients received the message\n", n)
}
```

### Consul {#update-consul}

``` golang
import (
    "github.com/hashicorp/consul/api"
)

func consulDo(index int) {
    // Create client
    client, err := api.NewClient(&api.Config{
        Address: "http://" + ip + ":8500",
    })
    if err != nil {
        fmt.Println("error: ", err)
    }

    // Get KV handle
    kv := client.KV()
  
    // Note: no leading slash before datakit
    key := "/datakit/confd/host/netstat.conf"
    value := `
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
`
    // Write data
    p := &api.KVPair{Key: key, Value: []byte(value), Flags: 32}
    _, err = kv.Put(p, nil)
    if err != nil {
        fmt.Println("error: ", err)
    }

    p1 := &api.KVPair{Key: key1, Value: []byte(value), Flags: 32}
    _, err = kv.Put(p1, nil)
    if err != nil {
        fmt.Println("error: ", err)
    }
}
```

### AWS Secrets Manager  {#update-aws}

```golang
import (
    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    "github.com/aws/aws-sdk-go-v2/credentials"
    "github.com/aws/aws-sdk-go-v2/service/secretsmanager"
    "github.com/aws/smithy-go"
)

func awsSecretsManagerDo(index int) {
    // Create client
    region := "cn-north-1"
    config, err := config.LoadDefaultConfig(context.TODO(),
        config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider("<AccessKeyID>", "<SecretAccessKey>", "")),
        config.WithRegion(region),
    )
    // will use secret file like ~/.aws/config
    // config, err := config.LoadDefaultConfig(context.TODO(), config.WithRegion(region))
    if err != nil {
        fmt.Printf("ERROR config.LoadDefaultConfig : %v\n", err)
    }

    // Get KV handle
    conn := secretsmanager.NewFromConfig(config)
  
    key := "/datakit/confd/host/netstat.conf"
    // key := "/datakit/pipeline/metric/netstat.p"
    value := `
[[inputs.netstat]]
  ##(optional) collect interval, default is 10 seconds
  interval = '10s'

[inputs.netstat.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
`

    // Write data
    input := &secretsmanager.CreateSecretInput{
        // Description:  aws.String(""),
        Name:         aws.String(key),
        SecretString: aws.String(value),
    }

    result, err := conn.CreateSecret(context.TODO(), input)
    if err != nil {
        fmt.Println("error: ", err)
    }
}
```

### Nacos {#update-nacos}

1. Log in to the Nacos management page via the URL.
1. Create two namespaces `/datakit/confd` and `/datakit/pipeline`.
1. Create groups according to the `datakit/conf.d` and `datakit/pipeline` subdirectories.
1. Create `dataID` following the rules for `.conf` and `.p` files. Do not omit the suffix.
1. Add, delete, or modify `dataID` via the management page.

## Updating Pipelines in the Configuration Center {#update-config-pipeline}

Refer to [How the Configuration Center Updates Configuration](confd.md#update-config)

Change the key prefix `datakit/confd` to `datakit/pipeline` and add the "type/filename". For example, the key `datakit/pipeline/logging/nginx.p` holds the Pipeline text.

Updating Pipelines supports etcdV3/Consul/Redis/Zookeeper/AWS Secrets Manager/Nacos.

## Backend Data Source Software Version Notes {#backend-version}

During development and testing, the following versions of backend data source software were used.

- Redis     : v6.0.16
- etcd      : v3.3.0
- Consul    : v1.13.2
- Zookeeper : v3.7.0
- Nacos     : v2.1.2