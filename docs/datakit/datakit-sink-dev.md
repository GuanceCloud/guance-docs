# DataKit Sinker 开发
---

本文将讲述如何开发 DataKit 的 Sinker 模块(以下简称 Sinker 模块、Sinker)的新实例。适合于想开发 Sinker 新实例、或者想深入了解 Sinker 模块原理的同学。

## 如何开发 Sinker 实例

目前社区版只实现有限的几个 Sinker, 如果想要支持其它存储, 可以做对应开发(用 Go 语言), 大致分为以下几步(以 `influxdb` 举例):

- 克隆 [DataKit 代码](https://jihulab.com/guance-cloud/datakit){:target="_blank"}, 在 *io/sink/* 下面新建一个包, 名字叫 `sinkinfluxdb`(建议都以 `sink` 开头)。

- 在上面的包下新建一个源文件 `sink_influxdb.go`, 新建一个常量 `creatorID`, 不能与其它包里面的 `creatorID` 重名; 实现 `ISink` 的 `interface`, 具体是实现以下几个函数:

	- `GetInfo() *SinkInfo`: 返回 sink 实例的相关信息。目前有 `ID`(实例内部标识, 程序内部根据配置生成, 供内部使用, 配置中唯一) 、`CreateID`(实例创建标识, 代码中唯一)和支持的类型的简写(比方说 `Metrics` 返回的是 `M`)。
	- `LoadConfig(mConf map[string]interface{}) error`: 加载外部配置到内部。
	- `Write(pts []ISinkPoint) error`: 写入数据。

大致代码如下:

```golang
const creatorID = "influxdb"

type SinkInfluxDB struct {
  // 这里写连接、写入等操作内部需要用到的一些参数, 比如保存连接用到的参数等。
  ...
}

func (s *SinkInfluxDB) GetInfo() *SinkInfo {
  // 返回 sink 实例的相关信息
  ...
}

func (s *SinkInfluxDB) LoadConfig(mConf map[string]interface{}) error {
  // 加载外部配置到内部
  ...
}

func (s *SinkInfluxDB) Write(pts []sinkcommon.ISinkPoint) error {
  // 写入数据
  // 这里你可能要熟悉下 ISinkPoint 这个 interface, 里面有两个方法 ToPoint 和 ToJSON 供使用。
  //   ToPoint 返回的是 influxdb 的 point;
  //   ToJSON 返回的是结构体, 如果不想使用 influxdb 的东西可以使用这个。
  ...
}
```

最后，在 `io/sink/sink.go` 中引入新增的 sink:

```go
package sink

import (
  ...
	_ "gitlab.jiagouyun.com/cloudcare-tools/datakit/io/sink/sinkinfluxdb"
)
```

> 大体上可以参照 `influxdb` 的代码实现, 还是非常简单的。一切以简单为首要设计原则, 写的复杂了你自己也不愿维护。欢迎大家向 github 社区提交代码, 大家一起来维护。

- 第三步: 在 `datakit.conf` 里面增加配置, `target` 写上自定义的实例名, 即 `creatorID`, 唯一。比如:

```conf
...
[sinks]

  [[sinks.sink]]
    categories = ["M", "N", "K", "O", "CO", "L", "T", "R", "S"]
    target = "influxdb"
    host = "10.200.7.21:8086"
    protocol = "http"
    database = "db0"
    precision = "ns"
    timeout = "15s"
...
```

## 注意事项

1. 新实例需要自定义一个 `createID`，即这个实例的 "标识"，如 `influxdb`、`elasticsearch` 等，这个是不能和现有的 `createID` 重复的。在配置里面的 `target` 对应的就是这个 `createID`。
