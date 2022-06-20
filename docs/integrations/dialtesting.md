{{.CSS}}
# 网络拨测
---

- DataKit 版本：{{.Version}}
- 操作系统支持：`{{.AvailableArchs}}`

# {{.InputName}}

该采集器是网络拨测结果数据采集，所有拨测产生的数据，上报观测云。

## 视图预览
![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639533409-1b345371-21c3-4a47-8c25-977dd3fcc43e.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=897&id=u3dfd887c&margin=%5Bobject%20Object%5D&name=image.png&originHeight=897&originWidth=1825&originalType=binary&ratio=1&rotation=0&showTitle=false&size=120839&status=done&style=none&taskId=ub0f65419-dca6-44ef-9e3e-92fffcc5897&title=&width=1825)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639558459-ff0e0f5f-be80-407a-89f0-7d60d2d982bd.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=836&id=uca36837b&margin=%5Bobject%20Object%5D&name=image.png&originHeight=836&originWidth=1819&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134862&status=done&style=none&taskId=u30ca059f-29d3-45b7-8314-6c34ac05281&title=&width=1819)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639978400-b26cf690-dcae-468e-9891-8653b0f39d75.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=873&id=u6636f376&margin=%5Bobject%20Object%5D&name=image.png&originHeight=873&originWidth=1895&originalType=binary&ratio=1&rotation=0&showTitle=false&size=135896&status=done&style=none&taskId=u25b92c55-58fa-4662-a793-207e7fc8be9&title=&width=1895)

## 安装部署


### 配置实施


#### saas节点使用
名词解释：**saas节点**<br />df已利用云资源创建好的节点，目前分布于全国各地，还可根据具体需要进行节点扩增（例如具体省份、具体国家等），可直接用来执行拨测任务。

**创建任务步骤：**<br />云拨测 - 新建任务 - API拨测 / Brwser拨测 - 填写URL以及任务名称 - 选择拨测节点 - 选择拨测频率 - 保存<br />具体可参考[[云拨测-数据采集](https://www.yuque.com/dataflux/doc/qnfc4a#UkJNb)]

**任务配置名词解释**：<br />**API拨测：**针对接口级别的主动拨测，主要汇总并分析接口返回的状态码以及网络层的耗时信息；<br />**Browser：**针对页面级别的主动拨测，相较于API拨测得到的返回状态码及网络层的耗时信息外，还有页面具体资源（例如jss、css、图片等）的性能消耗数据。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639778219-511cf72a-6312-4c01-ba22-189b36e51274.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=569&id=CJ6WU&margin=%5Bobject%20Object%5D&name=image.png&originHeight=569&originWidth=1899&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63680&status=done&style=none&taskId=u80aa6e35-3022-46d3-921a-5f2b1e84a42&title=&width=1899)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639792909-7db49168-1bcb-402d-ad8e-d5ea06ae8be2.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=886&id=gm0IS&margin=%5Bobject%20Object%5D&name=image.png&originHeight=886&originWidth=940&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52613&status=done&style=none&taskId=u2b3565c9-8cbf-4a81-a334-e062b9b1bb9&title=&width=940)


#### 私有节点使用

名词解释：**私有节点**<br />用户可在自己的云服务器上或者各地机房所拥有的服务器上安装拨测-私有节点（本质上为datakit上的一个inputs功能），开启之后，即可作用于自己的拨测任务调度。

**前置条件**

- datakit 所在服务器（需要安装私有节点的服务器） <[安装 Datakit](https://www.yuque.com/dataflux/datakit/datakit-install)>

**私有节点创建：**<br />私有拨测节点部署，需在 [DataFlux 页面创建私有拨测节点](https://www.yuque.com/dataflux/doc/phmtep)。创建完成后，将页面上相关信息填入 `conf.d/network/dialtesting.conf` 即可：
```
$ cd /usr/local/datakit/conf.d/ssh
$ cp ssh.conf.sample ssh.conf
$ vim ssh.conf



#  中心任务存储的服务地址
server = "https://dflux-dial.dataflux.cn"

# require，节点惟一标识ID
region_id = "reg_c2jlokxxxxxxxxxxx"

# 若server配为中心任务服务地址时，需要配置相应的ak或者sk
ak = "ZYxxxxxxxxxxxx"
sk = "BNFxxxxxxxxxxxxxxxxxxxxxxxxxxx"

pull_interval = "1m"

[inputs.dialtesting.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
  
$ wq!
```

**创建任务步骤：**<br />云拨测 - 新建任务 - API拨测 / Brwser拨测 - 填写URL以及任务名称 - 选择拨测节点 - 选择拨测频率 - 保存<br />具体可参考[[云拨测-数据采集](https://www.yuque.com/dataflux/doc/qnfc4a#UkJNb)]

**任务配置名词解释**：<br />**API拨测：**针对接口级别的主动拨测，主要汇总并分析接口返回的状态码以及网络层的耗时信息；<br />**Browser：**针对页面级别的主动拨测，相较于API拨测得到的返回状态码及网络层的耗时信息外，还有页面具体资源（例如jss、css、图片等）的性能消耗数据。<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639778219-511cf72a-6312-4c01-ba22-189b36e51274.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=569&id=JkzJ6&margin=%5Bobject%20Object%5D&name=image.png&originHeight=569&originWidth=1899&originalType=binary&ratio=1&rotation=0&showTitle=false&size=63680&status=done&style=none&taskId=u80aa6e35-3022-46d3-921a-5f2b1e84a42&title=&width=1899)<br />![image.png](https://cdn.nlark.com/yuque/0/2021/png/21516613/1630639792909-7db49168-1bcb-402d-ad8e-d5ea06ae8be2.png#clientId=u657514fb-b813-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=886&id=mwyeD&margin=%5Bobject%20Object%5D&name=image.png&originHeight=886&originWidth=940&originalType=binary&ratio=1&rotation=0&showTitle=false&size=52613&status=done&style=none&taskId=u2b3565c9-8cbf-4a81-a334-e062b9b1bb9&title=&width=940)


注意：<br />如需利用私有节点进行browser类型任务的拨测，需要在安装私有节点的服务器上安装Chrome浏览器
```
### 举例： Ubuntu

sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
```
下载完之后，无需修改datakit配置，只需在 DataFlux平台 中设置浏览器拨测任务即可。<br />具体可参考[[云拨测-数据采集](https://www.yuque.com/dataflux/doc/qnfc4a#UkJNb)]


#### [云拨测分析](https://www.yuque.com/dataflux/doc/tglyg8)

## 场景视图
DF平台已默认内置，无需手动创建

## 异常检测
异常检测库 - 新建检测库 - Nginx 检测库 
相关文档 
<[DataFlux 内置检测库](https://www.yuque.com/dataflux/doc/br0rm2)> 

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
| 1 | 拨测错误次数异常告警 | error次数 >=3 | 警告<br /> | 1m |
| 2 | 拨测错误次数异常告警 | error次数 >=10<br /> | 紧急 | 1m |


## 指标集

以下所有数据采集，默认会追加名为 `host` 的全局 tag（tag 值为 DataKit 所在主机名），也可以在配置中通过 `[[inputs.{{.InputName}}.tags]]` 另择 host 来命名。

{{ range $i, $m := .Measurements }}

### `{{$m.Name}}`

-  标签

{{$m.TagsMarkdownTable}}

- 指标列表

{{$m.FieldsMarkdownTable}}

{{ end }}


## `traceroute` 字段描述

traceroute 是「路由跟踪」数据的 JSON 文本，整个数据是一个数组对象，对象中的每个数组元素记录了一次路由探测的相关情况，示例如下：

```json
[
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 12700395,
        "min_cost": 11902041,
        "max_cost": 13498750,
        "std_cost": 1129043,
        "items": [
            {
                "ip": "10.8.9.1",
                "response_time": 13498750
            },
            {
                "ip": "10.8.9.1",
                "response_time": 11902041
            }
        ]
    },
    {
        "total": 2,
        "failed": 0,
        "loss": 0,
        "avg_cost": 13775021,
        "min_cost": 13740084,
        "max_cost": 13809959,
        "std_cost": 49409,
        "items": [
            {
                "ip": "10.12.168.218",
                "response_time": 13740084
            },
            {
                "ip": "10.12.168.218",
                "response_time": 13809959
            }
        ]
    }
]
```

**字段描述：**

| 字段              | 类型   |  说明                                    |
| :---              | ---    |  ---                                     |
| `total` | number | 总探测次数 |
| `failed` | number | 失败次数 |
| `loss` | number | 失败百分比 |
| `avg_cost` | number | 平均耗时(ns) |
| `min_cost` | number | 最小耗时(ns) |
| `max_cost` | number | 最大耗时(ns) |
| `std_cost` | number | 耗时标准差(ns) |
| `items` | Item 的 Array | 每次探测信息([详见](#Item)) |

### Item

| 字段              | 类型   |  说明                                    |
| :---              | ---    |  ---                                     |
| `ip` | string | IP 地址，如果失败，值为 * |
| `response_time` | number | 响应时间(ns) |


## 最佳实践
暂无

## 故障排查
<[无数据上报排查](why-no-data)>
