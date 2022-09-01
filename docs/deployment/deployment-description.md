---

观测云部署版支持用户在自己本地基础设施环境，或私有云环境上，安装观测云系统软件并运行服务。包括商业部署版和社区版两种，其中商业部署版分成订阅制版、许可证制版和按量付费版。

## 产品架构
![](https://cdn.nlark.com/yuque/0/2022/jpeg/21511589/1651151631374-27369c0e-8084-4328-b82b-f2a8fe4ff9e6.jpeg)
## 社区版

观测云社区版为老师、学生、云计算爱好者等社区用户提供一个简单易得又功能完备的产品化本地部署平台。欢迎免费申请并下载试用，搭建您自己的观测云平台，体验完整的产品功能。

### 使用步骤

#### Step1：部署社区版

您可以选择参考文档 [云上部署](https://www.yuque.com/dataflux/rtm/owi0v8) 或者 [线下环境部署](https://www.yuque.com/dataflux/rtm/zy5pdk)  或者 [阿里云计算巢部署](https://help.aliyun.com/document_detail/416711.html?spm=5176.26884182.J_4028621810.1.3a4b7bbbT89v0m)，进行线上或者线下部署。

#### Step2：获取社区版 License 和 AK/SK

##### 注册社区版账号
方式1：打开观测云 Launcher，点击右上角“设置”中的“License 激活及 AK/SK 配置”菜单，可以扫码关注“观测云”服务号，获取到社区版注册地址：
![image.png](https://cdn.nlark.com/yuque/0/2022/png/21511589/1651030790943-f2114844-3170-4e6c-9c02-8c28757c7474.png#clientId=u7423b9a3-5f48-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=624&id=u2a1ae24a&margin=%5Bobject%20Object%5D&name=image.png&originHeight=624&originWidth=888&originalType=binary&ratio=1&rotation=0&showTitle=false&size=96901&status=done&style=stroke&taskId=uca0d7801-896a-4dec-beb4-617b63e6adc&title=&width=888)

方式2：或者直接打开社区版注册地址（[https://boss.guance.com/index.html#/signup?type=community](https://boss.guance.com/index.html#/signup?type=community)），根据提示注册社区版账号。
![13.community_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805060711-c4ac0eea-0326-4945-b2d4-d1810dbd15b5.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=ud0f3d634&margin=%5Bobject%20Object%5D&name=13.community_1.png&originHeight=595&originWidth=693&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53431&status=done&style=stroke&taskId=u248f9f55-52eb-428a-9506-de7322faba9&title=)

注册完成后，进入观测云社区版费用中心。
![13.community_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805744575-47205c41-6934-479a-9637-6f0621591965.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u3e7d04db&margin=%5Bobject%20Object%5D&name=13.community_2.png&originHeight=436&originWidth=1430&originalType=binary&ratio=1&rotation=0&showTitle=false&size=54498&status=done&style=stroke&taskId=u0d62100b-dcf7-4085-9fdb-72f95fbc2cc&title=)

##### 获取 AK/SK

在观测云社区版费用中心的“AK 管理”，点击“创建 AK”，创建的 AK 和 SK复制后可填入“Step4：激活社区版”的 AK 和 SK 中。
![13.community_3.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805750605-2b922e66-4950-40ad-8b2d-7242f1dc0048.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u372c9f85&margin=%5Bobject%20Object%5D&name=13.community_3.png&originHeight=408&originWidth=1431&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60286&status=done&style=stroke&taskId=u90418e28-5666-4379-bfad-bcc670221de&title=)
##### 获取 License

在观测云社区版费用中心的“License 管理”，点击“创建 License”，创建 License 时需要同意社区版用户许可协议并通过手机验证。创建的 License 复制后可填入“Step2：激活社区版”的 License 文本中。
![13.community_4.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650805942748-8e71583b-6014-469e-a9c2-51ec27d384ce.png#clientId=uc47e3e1e-e2c4-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u99e59019&margin=%5Bobject%20Object%5D&name=13.community_4.png&originHeight=404&originWidth=1429&originalType=binary&ratio=1&rotation=0&showTitle=false&size=57738&status=done&style=stroke&taskId=u28263956-928e-48bc-ad80-d0257e2d60f&title=)

#### Step3：部署数据网关 DataWay

除了获取 AK、AS 和 License ，激活社区版还需要填入数据网关地址用来接收观测云的可用性监测服务中心数据，关于如何部署数据网关，可参考文档 [部署 DataWay](https://www.yuque.com/dataflux/rtm/weiyg5#e4FZe) 。
#### 
#### Step4：激活社区版

通过以上步骤，获取到 License、AK/SK 后，打开观测云 Launcher，点击右上角“设置”中的“License 激活及 AK/SK 配置”菜单：
![1.launcher_1.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650365861656-e63972eb-0cba-4eef-b008-80f65ee89ce1.png#clientId=u06a8da02-f67c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=fT5T9&margin=%5Bobject%20Object%5D&name=1.launcher_1.png&originHeight=663&originWidth=1312&originalType=binary&ratio=1&rotation=0&showTitle=false&size=134043&status=done&style=stroke&taskId=ua994e810-3bfc-49ce-a27c-3193c04d8a0&title=)
填写前面获取到的 License、AK/SK 以及数据网关地址，完成社区版的激活：
![13.community_5.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650806605707-bbfded2d-b528-40ec-84df-a49f46efe9ab.png#clientId=u4b724c7d-6e6e-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=UHrDh&margin=%5Bobject%20Object%5D&name=13.community_5.png&originHeight=624&originWidth=888&originalType=binary&ratio=1&rotation=0&showTitle=false&size=103460&status=done&style=stroke&taskId=u9540d53c-f36a-43ce-95fd-06dfb3e0374&title=)
**注：“数据网关地址”的配置中， 问号后面的**`**?token={}**`** 这部分原样填写，不要改动。**

#### Step5：开始使用观测云

社区版激活以后，即可创建工作空间，开始使用观测云。关于如何如何创建观测云社区版用户和工作空间，可参考文档 [开始使用](https://www.yuque.com/dataflux/rtm/weiyg5#J9IWP) 。
![1.community.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650374516786-63cac032-6986-4a5a-922d-03bb7d25bcb2.png#clientId=u31840a49-9a9b-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=GEO12&margin=%5Bobject%20Object%5D&name=1.community.png&originHeight=783&originWidth=1418&originalType=binary&ratio=1&rotation=0&showTitle=false&size=105207&status=done&style=stroke&taskId=u807fb03b-3e95-4bfc-8d5d-048bb50f94f&title=)

## 商业部署版

观测云社区版可以通过版本升级的方式，升到商业部署版。商业部署版是通过订阅或购买许可证的方式，获得观测云平台本地安装包和授权许可，来打造您的专属版观测云。在服务期内，观测云将持续提供升级包和在线支持服务，保障您的平台可以升级到最新版本。
![13.community_6.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1650807741407-f0b66109-7faf-425f-9794-ee8f9af6d6f2.png#clientId=u2eabd6d3-d5be-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u47e48503&margin=%5Bobject%20Object%5D&name=13.community_6.png&originHeight=707&originWidth=1428&originalType=binary&ratio=1&rotation=0&showTitle=false&size=145676&status=done&style=stroke&taskId=u93764b42-c26b-4c57-879d-ba9edb502f4&title=)
### 按量付费版

最终用户以按天订阅方式获得观测云软件使用授权，授权单位为当天统计到的最大在线活跃的接入采集器个数。在订阅期内，用户可以始终获取观测云软件最新版本升级，和享受标准支持服务。

注意：按量付费版需要实时向观测云在公网的网关上报用量数据。

### 订阅制版

最终用户以按年订阅方式获得观测云软件使用授权，授权单位为支持接入的采集器个数。在订阅期内，用户可以始终获取观测云软件最新版本升级，和享受标准支持服务。

注意：订阅制版最短订阅周期为1年。

### 许可证制版

最终用户可用一次性支付费用方式，获得观测云指定版本的永久使用权，授权单位为支持接入的采集器个数。购买默认赠送1年维保服务，用户可按年付费续约维保服务。在维保服务有效期内，用户可以始终获取观测云软件最新版本升级，和享受标准支持服务。

## 版本对比

| 版本 |  | 可用时长 | 升级服务 | 技术支持 | 安装包获取方式 | 授权许可(License) |
| --- | --- | --- | --- | --- | --- | --- |
| 商业部署版 | 订阅制版 | 1年起订，按年续订 | 订阅有效期内可升级 | 订阅有效期内：5*8小时 | 任意支持的获取路径 | 需要 |
|  | 许可证制版 | 永久，赠送一年维保，维保按年续订 | 维保有效期内可升级 | 维保有效期内：5*8小时 | 任意支持的获取路径 | 需要 |
|  | 按量付费版 | 1天起订，按天续订 | 订阅有效期内可升级 | 订阅有效期内：5*8小时 | 任意支持的获取路径 | 需要 |
| 社区版 |  | 每个版本可在发布日起180天内使用 | 自行升级 | 社区支持 | 任意支持的获取路径 | 需要 |





---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com/)
![](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png?x-oss-process=image%2Fresize%2Cw_746%2Climit_0#crop=0&crop=0&crop=1&crop=1&from=url&id=zEHmU&margin=%5Bobject%20Object%5D&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&status=done&style=none&title=)
