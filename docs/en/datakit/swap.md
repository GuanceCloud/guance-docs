
# Swap
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

The swap collector is used to collect the usage of the host swap memory.

## Preconditions {#requrements}

None

## Configuration {#config}

=== "Host Installation"

    Go to the `conf.d/host` directory under the DataKit installation directory, copy `swap.conf.sample` and name it `swap.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.swap]]
      ##(optional) collect interval, default is 10 seconds
      interval = '10s'
      ##
    
    [inputs.swap.tags]
    # some_tag = "some_value"
    # more_tag = "some_other_value"
    
    
    ```

    After configuration, restart DataKit.

=== "Kubernetes"

    Modifying configuration parameters as environment variables is supported:
    
    | Environment Variable Name                | Corresponding Configuration Parameter Item | Parameter Example                                                     |
    | :---                      | ---              | ---                                                          |
    | `ENV_INPUT_SWAP_TAGS`     | `tags`           | `tag1=value1,tag2=value2`. If there is a tag with the same name in the configuration file, it will be overwritten |
    | `ENV_INPUT_SWAP_INTERVAL` | `interval`       | `10s`                                                        |

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.swap.tags]`:

``` toml
 [inputs.swap.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `swap`

- tag


| 标签名 | 描述    |
|  ----  | --------|
|`host`|主机名|

- metric list


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`free`|Host swap memory total|int|B|
|`in`|Moving data from swap space to main memory of the machine|int|B|
|`out`|Moving main memory contents to swap disk when main memory space fills up|int|B|
|`total`|Host swap memory free|int|B|
|`used`|Host swap memory used|int|B|
|`used_percent`|Host swap memory percentage used|float|percent|


