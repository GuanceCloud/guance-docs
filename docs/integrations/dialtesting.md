
# DialTesting (云拨测)
---

- 操作系统支持：`windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64,darwin/amd64`

## 视图预览

![image](imgs/input-dialtesting-1.png)

![image](imgs/input-dialtesting-2.png)

![image](imgs/input-dialtesting-3.png)

## 安装部署

### 配置实施

#### saas节点使用

名词解释：**saas节点**
df已利用云资源创建好的节点，目前分布于全国各地，还可根据具体需要进行节点扩增（例如具体省份、具体国家等），可直接用来执行拨测任务。

**创建任务步骤：**
云拨测 - 新建任务 - API拨测 / Brwser拨测 - 填写URL以及任务名称 - 选择拨测节点 - 选择拨测频率 - 保存
具体可参考[[云拨测-数据采集](../usability-monitoring/dialingtest-task)]

**任务配置名词解释**：
**API拨测：** 针对接口级别的主动拨测，主要汇总并分析接口返回的状态码以及网络层的耗时信息；
**Browser：** 针对页面级别的主动拨测，相较于 API 拨测得到的返回状态码及网络层的耗时信息外，还有页面具体资源（例如 jss、css、图片等）的性能消耗数据。

![image](imgs/input-dialtesting-4.png)

![image](imgs/input-dialtesting-5.png)

#### 私有节点使用

名词解释：**私有节点**
用户可在自己的云服务器上或者各地机房所拥有的服务器上安装拨测-私有节点（本质上为 datakit 上的一个 inputs 功能），开启之后，即可作用于自己的拨测任务调度。

**前置条件**

- datakit 所在服务器（需要安装私有节点的服务器） <[安装 DataKit](../datakit/datakit-install.md)>

**私有节点创建：**
私有拨测节点部署，需在 [DataFlux 页面创建私有拨测节点](../usability-monitoring/self-node)。创建完成后，将页面上相关信息填入 `conf.d/network/dialtesting.conf` 即可：

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

**创建任务步骤：**
云拨测 - 新建任务 - API拨测 / Brwser拨测 - 填写URL以及任务名称 - 选择拨测节点 - 选择拨测频率 - 保存
具体可参考[[云拨测-数据采集](../usability-monitoring/dialingtest-task)]

**任务配置名词解释**：
**API拨测：** 针对接口级别的主动拨测，主要汇总并分析接口返回的状态码以及网络层的耗时信息；
**Browser：** 针对页面级别的主动拨测，相较于API拨测得到的返回状态码及网络层的耗时信息外，还有页面具体资源（例如jss、css、图片等）的性能消耗数据。

![image](imgs/input-dialtesting-6.png)

![image](imgs/input-dialtesting-7.png)

注意：
如需利用私有节点进行browser类型任务的拨测，需要在安装私有节点的服务器上安装Chrome浏览器

```
### 举例： Ubuntu

sudo apt-get install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
```

下载完之后，无需修改  DataKit 配置，只需在 DataFlux平台 中设置浏览器拨测任务即可。
具体可参考[[云拨测-数据采集](../usability-monitoring/dialingtest-task)]

#### [云拨测分析](../usability-monitoring/explorer)

## 场景视图

DF平台已默认内置，无需手动创建

## 异常检测

异常检测库 - 新建检测库 - Nginx 检测库 

| 序号 | 规则名称 | 触发条件 | 级别 | 检测频率 |
| --- | --- | --- | --- | --- |
| 1 | 拨测错误次数异常告警 | error次数 >=3 | 警告<br /> | 1m |
| 2 | 拨测错误次数异常告警 | error次数 >=10<br /> | 紧急 | 1m |

## 指标详解

<[云拨测指标详解](../datakit/dialtesting#measurements)>

## 最佳实践

暂无

## 故障排查

<[无数据上报排查](../datakit/why-no-data.md)>
