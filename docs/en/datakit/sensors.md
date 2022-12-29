<!-- This file required to translate to EN. -->

# 硬件温度 Sensors
---

:fontawesome-brands-linux:

---

计算机芯片温度数据采集，使用 `lm-sensors` 命令（目前仅支持 `Linux` 操作系统）

## 前置条件 {#requrements}

- 运行安装命令 `apt install lm-sensors -y`
- 运行扫描命令 `sudo sensors-detect` 输入 `Yes` 给每一个问题。
- 运行扫描结束后会看到 'service kmod start' 用来加载扫描到的 sensors，这条命令可能会因为您的操作系统不同而不同。

## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/sensors` 目录，复制 `sensors.conf.sample` 并命名为 `sensors.conf`。示例如下：
    
    ```toml
        
    [[inputs.sensors]]
      ## Command path of 'sensors' usually is /usr/bin/sensors
      # path = "/usr/bin/sensors"
    
      ## Gathering interval
      # interval = "10s"
    
      ## Command timeout
      # timeout = "3s"
    
      ## Customer tags, if set will be seen with every metric.
      [inputs.sensors.tags]
        # "key1" = "value1"
        # "key2" = "value2"
    
    ```
    
    配置好后，重启 DataKit 即可。

=== "Kubernetes"

    目前可以通过 [ConfigMap 方式注入采集器配置](datakit-daemonset-deploy.md#configmap-setting)来开启采集器。

## 指标集 {#measurements}

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[inputs.sensors.tags]` 指定其它标签：

```toml
 [inputs.sensors.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```



### `sensors`

- 标签


| 标签名 | 描述    |
|  ----  | --------|
|`adapter`|device adapter|
|`chip`|chip id|
|`feature`|gathering target|
|`hostname`|host name|

- 指标列表


| 指标 | 描述| 数据类型 | 单位   |
| ---- |---- | :---:    | :----: |
|`temp*_crit_alarm`|Alarm count, '*' is the order number in the chip list.|int|C|
|`temp*_input`|Current input temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_crit`|Critical temperature of this chip, '*' is the order number in the chip list.|int|C|
|`tmep*_max`|Max temperature of this chip, '*' is the order number in the chip list.|int|C|


